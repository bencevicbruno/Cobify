//
//  MockFavoritesService.swift
//  Cobify
//
//  Created by Bruno Bencevic on 19.12.2022..
//

import SwiftUI

final class MockFavoritesService: FavoritesServiceProtocol {
    
    private var favoriteSongIDs: Set<Int> = []
    private var subscribersForAdded = [Callback<Int>]()
    private var subscribersForRemoved = [Callback<Int>]()
    
    init() {
        print("favorites in init: \(favoriteSongIDs)")
    }
    
    func isFavorite(songID: Int) -> Bool {
        return favoriteSongIDs.contains(songID)
    }
    
    func addToFavorites(songID: Int) {
        print("Favoriting \(songID)")
        favoriteSongIDs.insert(songID)
        print("favorites: \(favoriteSongIDs)")
        
        subscribersForAdded.forEach { $0(songID) }
    }
    
    func removeFromFavorites(songID: Int)  {
        print("Removing \(songID)")
        favoriteSongIDs.remove(songID)
        print("favorites: \(favoriteSongIDs)")
        subscribersForRemoved.forEach { $0(songID) }
    }
    
    func favoriteBinding(for songID: Int, mutationCompletion: @escaping (Bool) -> Void) -> Binding<Bool> {
        return .init(get: { [weak self] in
            return self?.isFavorite(songID: songID) ?? false
        }, set: { [weak self] isFavorite in
            Task { @MainActor [weak self] in
                do {
                    if isFavorite {
                        self?.addToFavorites(songID: songID)
                    } else {
                         self?.removeFromFavorites(songID: songID)
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
