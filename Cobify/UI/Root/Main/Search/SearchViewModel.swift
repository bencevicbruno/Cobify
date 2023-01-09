//
//  SearchViewModel.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published private(set) var songs: [SongModel] = []
    
    var playingSong: Binding<PlayingSong?>!
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let favoritesService = ServiceFactory.favoritesService
    private let songsService = ServiceFactory.songsService
    
    init() {
        setupCancellables()
        
        
    }
    
    func songTapped(_ song: SongModel) {
        playingSong.wrappedValue = .init(model: song, source: .suggested)
    }
    
    func favoriteBinding(for songID: Int) -> Binding<Bool> {
        return favoritesService.favoriteBinding(for: songID) { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    var visibleSongs: [SongModel] {
        songs.filter {
            $0.artist.lowercased().contains(searchText.lowercased()) ||
            $0.title.lowercased().contains(searchText.lowercased())
        }
    }
    
    func fetchSongs() {
        self.songs = songsService.cachedSongs
    }
}

private extension SearchViewModel {
    
    func setupCancellables() {
//        self._searchText.projectedValue
//            .debounce(for: 0.2, scheduler: RunLoop.main)
//            .sink { [weak self] newValue in
//                self?.visibleSongs = .samples.filter {
//                    $0.title.lowercased().contains(newValue.lowercased()) || $0.artist.lowercased().contains(newValue.lowercased())
//                }
//            }
//            .store(in: &cancellables)
    }
}
