//
//  OnlineImage.swift
//  Cobify
//
//  Created by Bruno Bencevic on 20.12.2022..
//

import SwiftUI

struct OnlineImage<Content, Placeholder>: View where Content: View, Placeholder: View {
    
    @StateObject var viewModel: OnlineImageViewModel
    
    @ViewBuilder private let viewBuilder: (UIImage) -> Content
    @ViewBuilder private let placeholderViewBuilder: () -> Placeholder
    
    init(songID: Int, imageURL: String?,
         @ViewBuilder _ viewBuilder: @escaping (UIImage) -> Content,
         @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self._viewModel = StateObject(wrappedValue: OnlineImageViewModel(songID: songID, imageURL: imageURL))
        self.viewBuilder = viewBuilder
        self.placeholderViewBuilder = placeholder
    }
    
    var body: some View {
        if let image = viewModel.image {
            viewBuilder(image)
        } else {
            placeholderViewBuilder()
        }
    }
}

struct OnlineImage_Previews: PreviewProvider {
      
    static var previews: some View {
        OnlineImage(songID: 0, imageURL: "https://serviskosilica.hr/cms/wp-content/uploads/2020/07/alko2.jpg") { image in
            Image(uiImage: image)
        } placeholder: {
            Text("Loading...")
        }
    }
}
