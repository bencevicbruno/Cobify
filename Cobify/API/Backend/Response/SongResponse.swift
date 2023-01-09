//
//  SongResponse.swift
//  Cobify
//
//  Created by Bruno Bencevic on 17.12.2022..
//

import Foundation

struct SongResponse: Decodable {
    let id: Int
    let songName: String
    let artist: String
    let songURL: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case songName = "song-name"
        case artist
        case songURL = "song-url"
        case imageURL = "image-url"
    }
}
