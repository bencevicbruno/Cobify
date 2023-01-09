//
//  OnlineImagesService.swift
//  Cobify
//
//  Created by Bruno Bencevic on 20.12.2022..
//

import UIKit

final class OnlineImagesService {
    
    static let instance = OnlineImagesService()
    
    private var cache: [Int: UIImage] = [:]
    private var fetchingCache: [Int: Bool] = [:]
    
    init() {
        
    }
    
    func fetchImage(for songID: Int, songImageURL: String, onFetched: @escaping (UIImage) -> Void) {
        if let image = cache[songID] {
            onFetched(image)
        } else if let isFetching = fetchingCache[songID],
                  isFetching {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.fetchImage(for: songID, songImageURL: songImageURL, onFetched: onFetched)
            }
        } else {
            fetchImage(forID: songID, at: songImageURL, onFetched: onFetched)
        }
    }
}

private extension OnlineImagesService {
    
    func fetchImage(forID id: Int, at urlString: String, retriesLeft: Int = 5, onFetched: @escaping (UIImage) -> Void) {
        guard retriesLeft > 0,
              let url = URL(string: urlString),
              let token = ServiceFactory.persistenceService.authToken else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error downloading image from \(urlString): \(error)")
                print("\(String(describing: response))")
                self?.fetchImage(forID: id, at: urlString, retriesLeft: retriesLeft - 1, onFetched: onFetched)
            }
            
            guard let self = self else { return }
            guard let data = data else {
                print("No data recived for image from: \(urlString)")
                return
            }
//            print("image data: \(String(data: data, encoding: .utf8))")
            guard let image = UIImage(data: data) else {
                print("Unable to create image from data recieved from: \(urlString)")
                return }
            
            DispatchQueue.main.async { [weak self] in
                self?.cache[id] = image
                onFetched(image)
            }
        }.resume()
    }
}
