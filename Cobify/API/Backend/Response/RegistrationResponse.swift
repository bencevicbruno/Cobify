//
//  RegistrationResponse.swift
//  Cobify
//
//  Created by Bruno Bencevic on 03.01.2023..
//

import Foundation

struct RegistrationResponse: Decodable {
    let token: TokenResponse
    let user: UserIDResponse
    
    enum CodingKeys: String, CodingKey {
        case token = "auth-token"
        case user
    }
}
