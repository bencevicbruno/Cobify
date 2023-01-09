//
//  NetworkError.swift
//  Cobify
//
//  Created by Bruno Bencevic on 13.12.2022..
//

import Foundation

enum NetworkError: Error {
    case badURL(url: String)
    case responseNotHTTP
    case statusCode(code: Int)
}
