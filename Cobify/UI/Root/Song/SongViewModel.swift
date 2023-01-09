//
//  SongVIewModel.swift
//  Cobify
//
//  Created by Bruno Bencevic on 13.12.2022..
//

import SwiftUI
import Combine

final class SongViewModel: ObservableObject {
    
    @Published var isFavorite: Bool
    @Published var isPlaying = false
    
    @Published var progress: Double = 0
    
    let song: PlayingSong
    
    private var didStartPlaying = false
    private var currentDuration: Double = 0
    private var updateComingFromTimer = false
    private var duration: Double = 0
    private var cancellables: Set<AnyCancellable> = []
    private var timer: Timer!
    
    private let audioService = AudioService()
    private let favoritesService: FavoritesServiceProtocol = ServiceFactory.favoritesService
    
    init(song: PlayingSong) {
        self.song = song
        self.isFavorite = favoritesService.isFavorite(songID: song.id)
        setupCancellables()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self,
                  self.isPlaying,
                  self.duration != 0 else { return }
            
            let newProgress = self.progress + (self.currentDuration + 0.1) / self.duration
            if newProgress > 1.0 {
                self.songEnded()
            } else {
                self.updateComingFromTimer = true
                self.progress = newProgress
            }
        }
        
        // Comment-out for previews
//        try? audioService.playFromBundle()
        isPlaying = true
    }
    
    deinit {
        audioService.stopSound()
    }
    
    func songEnded() {
        audioService.stopSound()
    }
}

private extension SongViewModel {
    
    func setupCancellables() {
        self._isFavorite.projectedValue
            .sink { [weak self] value in
                guard let self = self else { return }
                
                self.favoritesService.favoriteBinding(for: self.song.id) { [weak self] _ in
                    self?.objectWillChange.send()
                }
                .wrappedValue = value
            }
            .store(in: &cancellables)
        
        self._progress.projectedValue
            .debounce(for: 0.01, scheduler: RunLoop.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                
                self.isPlaying = true
                if self.updateComingFromTimer {
                    self.updateComingFromTimer = false
                } else {
                    self.audioService.playFrom(percentage: value)
                }
            }
            .store(in: &cancellables)
        
        self._isPlaying.projectedValue
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if !self.didStartPlaying && value {
                    self.duration = (try? self.audioService.play(file: "song_\(self.song.id).mp3")) ?? 0
                    self.didStartPlaying = true
                    return
                }
                
                if value {
                    self.audioService.resumeSound()
                } else {
                    self.audioService.pauseSound()
                }
            }
            .store(in: &cancellables)
    }
}
