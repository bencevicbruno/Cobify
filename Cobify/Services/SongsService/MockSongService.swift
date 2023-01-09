//
//  SongsService.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import Foundation

final class MockSongService: SongsServiceProtocol {
    
    static let instance = MockSongService()
    
    init() {
        
    }
    
    var cachedSongs: [SongModel] = .samples
    
    func fetchRecommendedSongs() async throws -> [SongModel] {
        try await Task.sleep(for: .seconds(1))
        
        return .samples
    }
    
    func fetchFavoriteSongs() async throws -> [SongModel] {
        return .samples
    }
    
    func fetchSongDetails(byID id: Int) async throws -> SongModel {
        return [SongModel].samples.first(where: { $0.id == id }) ?? .sample
    }
}
