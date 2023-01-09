//
//  FavoritesView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 20.11.2022..
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var viewModel = FavoritesViewModel()
    
    var body: some View {
        Group {
            if viewModel.favoriteSongs.isEmpty {
                Text("Tap on little heart icons to add songs to your favorites !")
                    .fontWeight(.bold)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(20)
                    .frame(size: UIScreen.width * 0.8)
                    .background(BlurredView(style: .light))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                favoritesList
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            NavigationBar("Favorites", icon: "")
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.playingSong = mainViewModel.playingSongBinding
        }
    }
}

private extension FavoritesView {
    
    var favoritesList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.favoriteSongs) { song in
                    RecommendedSongCell(model: song, isFavorite: viewModel.favoriteBinding(for: song.id))
                        .onTapGesture {
                            viewModel.songTapped(song)
                        }
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, NavigationBar.totalHeight + 12)
            .padding(.bottom, MainTabBar.totalHeight)
        }
        .allowsHitTesting(!viewModel.isTaskRunning)
        .overlay {
            LoadingOverlay(isVisible: viewModel.isTaskRunning)
                .padding(.top, NavigationBar.totalHeight)
                .padding(.bottom, MainTabBar.totalHeight)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .edgesIgnoringSafeArea(.all)
    }
}
