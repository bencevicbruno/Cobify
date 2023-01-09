//
//  Icon.swift
//  Cobify
//
//  Created by Bruno Bencevic on 28.11.2022..
//

import SwiftUI

struct Icon: View {
    
    private let imageName: String
    private let iconSize: CGFloat
    private let frameSize: CGFloat
    private let onTapped: EmptyCallback
    
    init(_ imageName: String, iconSize: CGFloat = 24, frameSize: CGFloat = 24, _ onTapped: @escaping EmptyCallback = {}) {
        self.imageName = imageName
        self.iconSize = iconSize
        self.frameSize = frameSize
        self.onTapped = onTapped
    }
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(size: iconSize)
            .frame(size: frameSize)
            .contentShape(Rectangle())
            .onTapGesture {
                onTapped()
            }
    }
}

struct Icon_Previews: PreviewProvider {
    
    static var previews: some View {
        Icon("heart")
    }
}
