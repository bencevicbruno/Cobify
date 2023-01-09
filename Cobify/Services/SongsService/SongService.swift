//
//  RealSongService.swift
//  Cobify
//
//  Created by Bruno Bencevic on 12.12.2022..
//

import Foundation

final class SongService: SongsServiceProtocol {
    
    private let backend = BackendAPI.instance
    
    var cachedSongs: [SongModel] = []
    
    
    func fetchRecommendedSongs() async throws -> [SongModel] {
        let songs: [SongModel] = try await backend.fetchSongs().map { .init(from: $0) }
        self.cachedSongs = songs
        return songs
    }
    
    func fetchFavoriteSongs() async throws -> [SongModel] {
        return try await backend.fetchSongs().map { .init(from: $0) }
    }
    
    func fetchSongDetails(byID id: Int) async throws -> SongModel {
        if let song = cachedSongs.first(where: { $0.id == id }) {
            return song
        }
        
        let response = try await backend.fetchSong(byID: id)
        return .init(from: response)
    }
}
