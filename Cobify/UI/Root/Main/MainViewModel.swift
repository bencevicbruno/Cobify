//
//  MainViewModel.swift
//  Cobify
//
//  Created by Bruno Bencevic on 08.12.2022..
//

import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    
    @Binding var state: AuthState
    
    @Published var currentTab = MainTab.home
    @Published var isTabBarVisible = true
    @Published var playingSong: PlayingSong?
    
    init(authState: Binding<AuthState>) {
        self._state = authState
    }
    
    var playingSongBinding: Binding<PlayingSong?> {
        .init(get: { [unowned self] in
            self.playingSong
        }, set: { [unowned self] newValue in
            self.playingSong = newValue
        })
    }
    
    var isTabBarVisibleBinding: Binding<Bool> {
        .init(get: { [unowned self] in
            self.isTabBarVisible
        }, set: { [unowned self] newValue in
            self.isTabBarVisible = newValue
        })
    }
}
