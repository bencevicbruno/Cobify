//
//  MainTab.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import Foundation

enum MainTab: Identifiable, CaseIterable {
    case home
    case search
    case playlists
    
    var id: Self {
        self
    }
    
    var systemImageName: String {
        switch self {
        case .home:
            return "music.note.house"
        case .search:
            return "magnifyingglass"
        case .playlists:
            return "heart"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .playlists:
            return "Playlists"
        }
    }
}
