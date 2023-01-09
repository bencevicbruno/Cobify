//
//  FavoritesServiceProtocol.swift
//  Cobify
//
//  Created by Bruno Bencevic on 19.12.2022..
//

import SwiftUI

protocol FavoritesServiceProtocol {
    
    func isFavorite(songID: Int) -> Bool
    func addToFavorites(songID: Int)
    func removeFromFavorites(songID: Int)
    
    func favoriteBinding(for songID: Int, mutationCompletion: @escaping (Bool) -> Void) -> Binding<Bool>
    
    func getListOfFavorites() -> Set<Int>
    func subscribeForNewFavorites(subscription: @escaping Callback<Int>)
    func subscribeForRemovingFavorites(subscription: @escaping Callback<Int>)
}
