//
//  MainView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 20.11.2022..
//

import SwiftUI

struct MainView: View {
    
    @StateObject var mainViewModel: MainViewModel
    
    init(authState: Binding<AuthState>) {
        self._mainViewModel = .init(wrappedValue: .init(authState: authState))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $mainViewModel.currentTab) {
                HomeView()
                    .environmentObject(mainViewModel)
                    .tag(MainTab.home)
                
                SearchView()
                    .environmentObject(mainViewModel)
                    .tag(MainTab.search)
                
                FavoritesView()
                    .environmentObject(mainViewModel)
                    .tag(MainTab.playlists)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            if mainViewModel.isTabBarVisible {
                MainTabBar(currentTab: $mainViewModel.currentTab)
                    .transition(.move(edge: .bottom))
            }
        }
        .background(
            GeometricBackground()
                .frame(width: UIScreen.width, height: UIScreen.height, alignment: mainViewModel.currentTab == .home ? .leading : mainViewModel.currentTab == .search ? .center : .trailing)
        )
        .sheet(item: $mainViewModel.playingSong) { song in
            SongView(song: song)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView(authState: .constant(.loggedIn))
            .edgesIgnoringSafeArea(.all)
    }
}
