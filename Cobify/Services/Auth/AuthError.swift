//
//  AuthError.swift
//  Cobify
//
//  Created by Bruno Bencevic on 21.12.2022..
//

import Foundation

enum AuthError: Error {
    case invalidCredentials
    case alreadyRegistered
}
