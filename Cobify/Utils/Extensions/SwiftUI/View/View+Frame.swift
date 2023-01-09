//
//  View+Frame.swift
//  Cobify
//
//  Created by Bruno Bencevic on 18.11.2022..
//

import SwiftUI

extension View {
    
    func frame(size: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(width: size, height: size, alignment: alignment)
    }
    
    func frame(maxWidth: CGFloat, height: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: maxWidth, alignment: alignment)
            .frame(height: height, alignment: alignment)
    }
}
