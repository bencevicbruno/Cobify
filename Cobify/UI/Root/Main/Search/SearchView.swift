//
//  SearchView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        Group {
            if viewModel.searchText.isEmpty {
                Text("Start typing and search results will appear here.")
                    .fontWeight(.bold)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(20)
                    .frame(size: UIScreen.width * 0.8)
                    .background(BlurredView(style: .light))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                if viewModel.visibleSongs.isEmpty {
                    Text("Sorry, no results found...")
                        .fontWeight(.bold)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(20)
                        .frame(size: UIScreen.width * 0.8)
                        .background(BlurredView(style: .light))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } else {
                    searchResultsList
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            NavigationBar("Search", icon: "", containsBottomPadding: true)
            .overlay(alignment: .bottom) {
                searchField
                    .padding(.horizontal, 12)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.playingSong = mainViewModel.playingSongBinding
            viewModel.fetchSongs()
        }
    }
}

private extension SearchView {
    
    var searchField: some View {
        HStack(spacing: 12) {
            TextField("Search", text: $viewModel.searchText)
                .frame(maxWidth: .infinity, height: 40)
            
            Icon("x.circle.fill") {
                viewModel.searchText = ""
            }
        }
        .padding(.horizontal, 8)
        .foregroundColor(.cobifyOnyx)
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .background(BlurredView(style: .light))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 10)
        .frame(height: 60)
    }
    
    var searchResultsList: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.visibleSongs) { song in
                    RecommendedSongCell(model: song, isFavorite: viewModel.favoriteBinding(for: song.id))
                        .onTapGesture {
                            viewModel.songTapped(song)
                        }
                }
            }
            .padding(.top, NavigationBar.totalHeight + NavigationBar.bottomPadding)
            .padding(.bottom, MainTabBar.totalHeight)
            .padding(12)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchView()
            .edgesIgnoringSafeArea(.all)
    }
}
