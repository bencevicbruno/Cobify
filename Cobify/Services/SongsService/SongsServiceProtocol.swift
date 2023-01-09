//
//  SongsServiceProtocol.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import Foundation

protocol SongsServiceProtocol {
    
    var cachedSongs: [SongModel] { get }
    
    func fetchRecommendedSongs() async throws -> [SongModel]
    func fetchFavoriteSongs() async throws -> [SongModel]
    func fetchSongDetails(byID id: Int) async throws -> SongModel
}
