//
//  View+Visibility.swift
//  Cobify
//
//  Created by Bruno Bencevic on 16.11.2022..
//

import SwiftUI

extension View {
    
    func isVisible(_ isVisible: Bool) -> some View {
        self.opacity(isVisible ? 1 : 0)
            .allowsHitTesting(isVisible)
    }
    
    func isHidden(_ isHidden: Bool) -> some View {
        self.opacity(isHidden ? 0 : 1)
            .allowsHitTesting(!isHidden)
    }
}
