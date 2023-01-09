//
//  FavoritesService.swift
//  Cobify
//
//  Created by Bruno Bencevic on 19.12.2022..
//

import SwiftUI

final class FavoritesService: FavoritesServiceProtocol {
    
    private let backend = BackendAPI.instance
    private let persistenceService = ServiceFactory.persistenceService
    
    private var favoriteSongIDs: Set<Int> = []
    private var subscribersForAdded = [Callback<Int>]()
    private var subscribersForRemoved = [Callback<Int>]()
    
    init() {
        print("favorites in init: \(favoriteSongIDs)")
        
        Task { @MainActor in
            guard let userID = self.persistenceService.currentUserID else { return }
                    
            do {
                let favorites = try await self.backend.fetchAllFavorites(userID: userID)
                
                favorites.forEach {
                    self.addToFavorites(songID: $0.id)
                }
            } catch {
                print("Error fetching favorites: \(error)")
            }
        }
    }
    
    func isFavorite(songID: Int) -> Bool {
        return favoriteSongIDs.contains(songID)
    }
    
    func addToFavorites(songID: Int)  {
        print("Favoriting \(songID)")
        favoriteSongIDs.insert(songID)
        print("favorites: \(favoriteSongIDs)")
        
        subscribersForAdded.forEach { $0(songID) }
        
        guard let userID = self.persistenceService.currentUserID else { return }
        
        Task {
            try? await self.backend.addToFavorites(userID: userID, songID: songID)
        }
    }
    
    func removeFromFavorites(songID: Int) {
        print("Removing \(songID)")
        favoriteSongIDs.remove(songID)
        print("favorites: \(favoriteSongIDs)")
        subscribersForRemoved.forEach { $0(songID) }
        
        guard let userID = self.persistenceService.currentUserID else { return }
        Task {
            try? await self.backend.removeFromFavorites(userID: userID, songID: songID)
        }
    }
    
    func favoriteBinding(for songID: Int, mutationCompletion: @escaping (Bool) -> Void) -> Binding<Bool> {
        return .init(get: { [weak self] in
            return self?.isFavorite(songID: songID) ?? false
        }, set: { [weak self] isFavorite in
            Task { @MainActor [weak self] in
                do {
                    if isFavorite {
                        try await self?.addToFavorites(songID: songID)
                    } else {
                        try await self?.removeFromFavorites(songID: songID)
                    }
                    
                    mutationCompletion(isFavorite)
                } catch {
                    if isFavorite {
                        print("[ERROR] Unable to add song to favorites.")
                    } else {
                        print("[ERROR] Unable to remove song from favorites.")
                    }
                }
            }
        })
    }
    
    func getListOfFavorites() -> Set<Int> {
        return favoriteSongIDs
    }
    
    func subscribeForNewFavorites(subscription: @escaping Callback<Int>) {
        subscribersForAdded.append(subscription)
    }
    
    func subscribeForRemovingFavorites(subscription: @escaping Callback<Int>) {
        subscribersForRemoved.append(subscription)
    }
}
