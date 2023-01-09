//
//  NetworkService.swift
//  Cobify
//
//  Created by Bruno Bencevic on 13.12.2022..
//

import Foundation

final class NetworkService {
    
    private let jsonDecoder = JSONDecoder()
    
    private let persistenceService = ServiceFactory.persistenceService
    
    init() {}
    
    func fetch<T>(request: URLRequest) async throws -> T where T: Decodable {
        var request = request
        
        if let token = persistenceService.authToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let data = try await fetchRaw(request: request)
        
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    func fetchRaw(request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("Got response: \(response)")
        print("Data: \(String(describing: String(data: data, encoding: .utf8)))")
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.responseNotHTTP
        }
        
        guard response.statusCode == 200 else {
            throw NetworkError.statusCode(code: response.statusCode)
        }
        
        return data
    }
    
    func fetch(request: URLRequest) async throws {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("Got response: \(response)")
        print("Data: \(String(describing: String(data: data, encoding: .utf8)))")
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.responseNotHTTP
        }
        
        guard response.statusCode == 200 else {
            throw NetworkError.statusCode(code: response.statusCode)
        }
    }
    
    func fetchForRegister(request: URLRequest) async throws {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("Got response: \(response)")
        print("Data: \(String(describing: String(data: data, encoding: .utf8)))")
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.responseNotHTTP
        }
        
        guard response.statusCode == 200 || response.statusCode == 201 else {
            throw NetworkError.statusCode(code: response.statusCode)
        }
    }
}
