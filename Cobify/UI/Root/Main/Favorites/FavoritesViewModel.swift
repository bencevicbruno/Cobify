//
//  FavoritesViewModel.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import SwiftUI

final class FavoritesViewModel: ObservableObject {
    
    @Published var favoriteSongs: [SongModel] = []
    @Published var isTaskRunning = false
    
    var playingSong: Binding<PlayingSong?>!
    
    private let favoritesService = ServiceFactory.favoritesService
    private let songsService = ServiceFactory.songsService
    
    init() {
        fetchFavorites()
        
        favoritesService.subscribeForNewFavorites { [weak self] songID in
            DispatchQueue.main.async {
                self?.addToFavorites(songID: songID)
            }
        }
        
        favoritesService.subscribeForRemovingFavorites { [weak self] songID in
            DispatchQueue.main.async {
                self?.favoriteSongs.removeAll(where: { $0.id == songID })
            }
        }
    }
    
    func songTapped(_ song: SongModel) {
        playingSong.wrappedValue = .init(model: song, source: .suggested)
    }
    
    func favoriteBinding(for songID: Int) -> Binding<Bool> {
        return favoritesService.favoriteBinding(for: songID) { [weak self] isFavorite in
            if isFavorite {
                self?.addToFavorites(songID: songID)
            } else {
                withAnimation {
                    self?.favoriteSongs.removeAll(where: { $0.id == songID})
                    self?.objectWillChange.send()
                }
            }
        }
    }
    
    func addToFavorites(songID: Int) {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            do {
                self.favoriteSongs.append(try await songsService.fetchSongDetails(byID: songID))
            } catch {
                print("[ERROR] Fetching song with id \(songID) failed.")
            }
        }
    }
    
    func fetchFavorites() {
        let favorites = favoritesService.getListOfFavorites()
        
        favorites.forEach { songID in
            addToFavorites(songID: songID)
        }
    }
}
