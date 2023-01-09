//
//  ServiceFactory.swift
//  Cobify
//
//  Created by Bruno Bencevic on 17.12.2022..
//

import Foundation

struct ServiceFactory {
    
    private static let mockSongs = false
    private static let mockFavorites = false
    private static let mockAuth = false
    
    static let netowrkService = NetworkService()
    
    static let audioService = AudioService()
    
    static let songsService: SongsServiceProtocol = Self.mockSongs ? MockSongService() : SongService()
    
    static let favoritesService: FavoritesServiceProtocol = Self.mockFavorites ? MockFavoritesService() : FavoritesService()
    
    static let authService: AuthServiceProtocol = Self.mockAuth ? MockAuthService() : AuthService()
    
    static let persistenceService: PersistenceServiceProtocol = PersistenceService()
}
