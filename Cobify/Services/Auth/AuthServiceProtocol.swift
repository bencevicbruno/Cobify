//
//  AuthServiceProtocol.swift
//  Cobify
//
//  Created by Bruno Bencevic on 21.12.2022..
//

import Foundation

protocol AuthServiceProtocol {
    
    func login(email: String, password: String) async throws
    func register(email: String, password: String) async throws
}
