//
//  HomeView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 20.11.2022..
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        Group {
            if let error = viewModel.error {
                errorContent(error)
            } else if viewModel.songs.isEmpty && !viewModel.isInitialTask {
                emptyContent
            } else {
                content
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            NavigationBar("MyHome", icon: "arrowshape.right") {
                viewModel.logoutTapped()
            }
        }
        .overlay {
            LoadingOverlay(isVisible: viewModel.isTaskRunning)
                .padding(.top, NavigationBar.totalHeight)
                .padding(.bottom, MainTabBar.totalHeight)
        }
        .edgesIgnoringSafeArea(.all)
        .confirmationDialog(dialog: $viewModel.confirmationDialog)
        .onAppear {
            viewModel.authState = mainViewModel.$state
            viewModel.playingSong = mainViewModel.playingSongBinding
            viewModel.isTabBarVisible = mainViewModel.isTabBarVisibleBinding
        }
    }
}

private extension HomeView {
    
    var content: some View {
        RefreshableScrollView(showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.songs) { song in
                    RecommendedSongCell(model: song, isFavorite: viewModel.favoriteBinding(for: song.id))
                        .onTapGesture {
                            viewModel.songTapped(song)
                        }
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, NavigationBar.totalHeight + 12)
            .padding(.bottom, MainTabBar.totalHeight)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } onRefresh: {
            viewModel.fetchRecommendedSongs()
        }
        .allowsHitTesting(!viewModel.isTaskRunning)
    }
    
    var emptyContent: some View {
        EmptyStateCard(systemImageName: "music.quarternote.3",
                       title: "No recommended songs were found.") {
            viewModel.fetchRecommendedSongs()
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .allowsHitTesting(!viewModel.isTaskRunning)
        .padding(.top, NavigationBar.totalHeight + 12)
        .padding(.bottom, MainTabBar.totalHeight)
    }
    
    func errorContent(_ error: Error) -> some View {
        EmptyStateCard(systemImageName: "cellularbars",
                       title: "Error occured",
                       description: error.localizedDescription) {
            viewModel.fetchRecommendedSongs()
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .allowsHitTesting(!viewModel.isTaskRunning)
        .padding(.top, NavigationBar.totalHeight)
        .padding(.bottom, MainTabBar.totalHeight)
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}
