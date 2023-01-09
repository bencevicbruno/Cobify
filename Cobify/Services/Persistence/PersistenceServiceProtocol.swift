//
//  PersistenceServiceProtocol.swift
//  Cobify
//
//  Created by Bruno Bencevic on 28.12.2022..
//

import Foundation

protocol PersistenceServiceProtocol {
    
    var currentUserID: Int? { get set }
    var authToken: String? { get set }
}
