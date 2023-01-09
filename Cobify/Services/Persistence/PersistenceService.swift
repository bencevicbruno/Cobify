//
//  PersistenceService.swift
//  Cobify
//
//  Created by Bruno Bencevic on 28.12.2022..
//

import Foundation

final class PersistenceService: PersistenceServiceProtocol {
    
    private let userDefaults = UserDefaults.standard
    
    init() {
        
    }
    
    var currentUserID: Int? {
        get {
            userDefaults.integer(forKey: "currentUserID")
        } set {
            userDefaults.set(newValue, forKey: "currentUserID")
        }
    }
    
    var authToken: String? {
        get {
            userDefaults.string(forKey: "authToken")
        } set {
            userDefaults.set(newValue, forKey: "authToken")
        }
    }
}
