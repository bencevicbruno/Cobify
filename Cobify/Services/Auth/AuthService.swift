//
//  AuthService.swift
//  Cobify
//
//  Created by Bruno Bencevic on 28.12.2022..
//

import Foundation

final class AuthService: AuthServiceProtocol {
    
    private let backend = BackendAPI.instance
    
    private var persistenceService = ServiceFactory.persistenceService
    
    init() {
        
    }
    
    func login(email: String, password: String) async throws {
        let response = try await backend.generateToken(user: email, password: password)
        
        persistenceService.currentUserID = response.user.id
        persistenceService.authToken = response.token.token
    }
    
    func register(email: String, password: String) async throws {
        try await backend.createUser(username: email, password: password)
        try await login(email: email, password: password)
    }
}
