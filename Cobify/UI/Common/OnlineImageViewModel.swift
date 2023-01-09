//
//  OnlineImageViewModel.swift
//  watch_stage WatchKit Extension
//
//  Created by Bruno Benčević on 02.09.2022..
//

import UIKit

final class OnlineImageViewModel: ObservableObject {
    
    @Published var image: UIImage?
    
    private let onlineImagesService = OnlineImagesService.instance
    
    init(songID: Int, imageURL: String?) {
        guard let imageURL = imageURL else { return}

        onlineImagesService.fetchImage(for: songID, songImageURL: imageURL) { [weak self] image in
            self?.image = image
        }
    }
}
