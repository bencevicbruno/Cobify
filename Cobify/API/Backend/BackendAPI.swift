//
//  BackendAPI.swift
//  Cobify
//
//  Created by Bruno Bencevic on 12.12.2022..
//

import Foundation

final class BackendAPI {
    
    static let instance = BackendAPI(backendID: "0908-2a05-4f44-a18-b200-00-8")
    
    private let backendID: String
    
    private let networkService = NetworkService()
    
    private init(backendID: String) {
        self.backendID = backendID
    }
    
    func fetchSongs() async throws -> [SongResponse] {
        let urlString = "https://\(backendID).eu.ngrok.io/api/song"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL(url: urlString)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return try await networkService.fetch(request: request)
    }
    
    func fetchSong(byID id: Int) async throws -> SongResponse {
        let urlString = "https://\(backendID).eu.ngrok.io/api/song/\(id)"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL(url: urlString)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        return try await networkService.fetch(request: request)
    }
    
    func downloadSongFile(from url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkError.badURL(url: url)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = ServiceFactory.persistenceService.authToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return try await networkService.fetchRaw(request: request)
    }
    
    
    func generateToken(user: String, password: String) async throws -> RegistrationResponse {
        let urlString = "https://\(backendID).eu.ngrok.io/api/token/generate-token"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL(url: urlString)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: [
            "username": user,
            "password": password
        ])
        
        return try await networkService.fetch(request: request)
    }
    
    func fetchUserID(fromToken token: String) async throws -> UserIDResponse {
        let urlString = "https://\(backendID).eu.ngrok.io/api/token/current-user"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL(url: urlString)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return try await networkService.fetch(request: request)
    }
    
    func createUser(username: String, password: String) async throws {
        let urlString = "https://\(backendID).eu.ngrok.io/api/users/signup"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL(url: urlString)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestData = [
            "username": username,
            "email": username,
            "password": password,
            "firstName": username,
            "lastName": username,
            "avatarUrl": ""
        ]
        
        request.httpBody = try JSONEncoder().encode(requestData)
        try await networkService.fetchForRegister(request: request)
    }
    
    // MARK: - Favorites
    
    func fetchAllFavorites(userID: Int) async throws -> [SongResponse] {
        let urlString = "https://\(backendID).eu.ngrok.io/api/users/\(userID)/favorites"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL(url: urlString)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return try await networkService.fetch(request: request)
    }
    
    func addToFavorites(userID: Int, songID: Int) async throws {
        let urlString = "https://\(backendID).eu.ngrok.io/api/users/\(userID)/favorites"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL(url: urlString)
        }
        
        let requestData = [[
            "id": songID,
        ]]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(requestData)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(String(data: request.httpBody!, encoding: .utf8))
        
        try await networkService.fetch(request: request)
    }
    
    func removeFromFavorites(userID: Int, songID: Int) async throws {
        let urlString = "https://\(backendID).eu.ngrok.io/api/users/\(userID)/favorites"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL(url: urlString)
        }
        
        let requestData = [[
            "id": songID,
        ]]
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = try JSONEncoder().encode(requestData)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(String(data: request.httpBody!, encoding: .utf8))
        
        try await networkService.fetch(request: request)
    }
}
