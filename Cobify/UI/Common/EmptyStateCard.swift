//
//  EmptyStateCard.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import SwiftUI

struct EmptyStateCard: View {
    
    let imageName: String
    let title: String
    let description: String?
    let retryButtonTitle: String
    let onRetry: EmptyCallback
    
    init(systemImageName: String, title: String, description: String? = nil, retryButtonTitle: String = "Retry", onRetry: @escaping EmptyCallback = {}) {
        self.imageName = systemImageName
        self.title = title
        self.description = description
        self.retryButtonTitle = retryButtonTitle
        self.onRetry = onRetry
    }
    
    var body: some View {
        VStack(spacing: 36) {
            VStack(spacing: 0) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(1, contentMode: .fit)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .padding(.bottom, description == nil ? 0 : 8)
                
                if let description {
                    Text(description)
                        .font(.title3)
                        .fontWeight(.medium)
                        .lineLimit(3)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity)
            .background(BlurredView(style: .light))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Text(retryButtonTitle)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, height: 60)
                .background(BlurredView(style: .light))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 10)
                .onTapGesture {
                    onRetry()
                }
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.cobifyOnyx)
        .frame(width: UIScreen.width * 2 / 3)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct EmptyStateCard_Previews: PreviewProvider {
    
    static var previews: some View {
        EmptyStateCard(systemImageName: "music.quarternote.3",
                       title: "Not music 4 U",
                       description: "Oh well")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("placeholder_panda")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
        )
    }
}
