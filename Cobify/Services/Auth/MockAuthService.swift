//
//  MockAuthService.swift
//  Cobify
//
//  Created by Bruno Bencevic on 21.12.2022..
//

import Foundation

final class MockAuthService: AuthServiceProtocol {

    static let validMail = "@test"
    static let validPassword = "test"
    
    private var persistenceService = ServiceFactory.persistenceService
    
    init() {
        
    }
    
    func login(email: String, password: String) async throws {
//        try await Task.sleep(for: .milliseconds(500))
        
        if email == Self.validMail && password == Self.validPassword {
            persistenceService.authToken = ""
            persistenceService.currentUserID = 0
        } else {
            throw AuthError.invalidCredentials
        }
    }
    
    func register(email: String, password: String) async throws {
//        try await Task.sleep(for: .milliseconds(500))
        
        if email == Self.validMail && password == Self.validPassword {
            persistenceService.authToken = ""
            persistenceService.currentUserID = 0
        } else {
            throw AuthError.alreadyRegistered
        }
    }
}
