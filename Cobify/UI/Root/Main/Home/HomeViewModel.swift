//
//  HomeViewModel.swift
//  Cobify
//
//  Created by Bruno Bencevic on 28.11.2022..
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var songs: [SongModel] = []
    @Published var isTaskRunning = true
    @Published var isInitialTask = true
    @Published var error: Error?
    
    @Published var confirmationDialog: ConfirmationDialog?
    
    var authState: Binding<AuthState>!
    var playingSong: Binding<PlayingSong?>!
    var isTabBarVisible: Binding<Bool>!
    
    private var persistenceService = ServiceFactory.persistenceService
    private let songsService = ServiceFactory.songsService
    private let favoritesService: FavoritesServiceProtocol = ServiceFactory.favoritesService
    
    init() {
        fetchRecommendedSongs(force: true)
    }
    
    // MARK: - User Interactions
    
    func logoutTapped() {
        withAnimation {
            self.isTabBarVisible.wrappedValue = false
            confirmationDialog = .init(title: "Are you sure you want to log out?",
                                       message: "You can login back at any time.",
                                       confirmTitle: "Log Out",
                                       cancelTitle: "Cancel",
                                       confirmAction: { [weak self] in
                withAnimation {
                    self?.persistenceService.authToken = nil
                    self?.persistenceService.currentUserID = nil
                    self?.isTabBarVisible.wrappedValue = true
                    self?.authState.wrappedValue = .loggedOut
                }
            },
                                       cancelAction: { [weak self] in
                withAnimation {
                    self?.isTabBarVisible.wrappedValue = true
                }
            })
        }
    }
    
    func songTapped(_ song: SongModel) {
        startTask()
        Task { @MainActor [weak self] in
            do {
                let songData = try await BackendAPI.instance.downloadSongFile(from: song.audioURL)
                try songData.write(to: FileManager.default.getPath(for: "song_\(song.id).mp3"))
                endTask()
                
                playingSong.wrappedValue = .init(model: song, source: .suggested)
            } catch {
                print(error)
                endTask()
            }
        }
    }
    
    func favoriteBinding(for songID: Int) -> Binding<Bool> {
        return favoritesService.favoriteBinding(for: songID) { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    // MARK: - Tasks
    
    func startTask() {
        withAnimation {
            isTaskRunning = true
        }
    }
    
    func endTask() {
        withAnimation {
            isTaskRunning = false
        }
    }
    
    // MARK: - API Calls
    
    func fetchRecommendedSongs(force: Bool = false) {
        guard !isTaskRunning || force else { return }
        startTask()
        
        Task { @MainActor in
            do {
                self.songs = try await songsService.fetchRecommendedSongs()
                self.error = nil
                self.isInitialTask = false
            } catch {
                self.error = error
            }
            endTask()
        }
    }
}
