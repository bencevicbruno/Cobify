//
//  Color+.swift
//  Cobify
//
//  Created by Bruno Bencevic on 20.11.2022..
//

import SwiftUI

extension Color {
    
    static let cobifyFireOpal = Color(hex: 0xEF6461)
    static let cobifySunray = Color(hex: 0xE4B363)
    static let cobifyPlatinum = Color(hex: 0xE8EBE9)
    static let cobifyAlabaster = Color(hex: 0xE0DfD5)
    static let cobifyOnyx = Color(hex: 0x313638)
}

fileprivate extension Color {
    
    init(hex: Int) {
        let containsOpacity = hex > 0xFFFFFF
        let red = hex >> (containsOpacity ? 24 : 16) & 0xFF
        let green = hex >> (containsOpacity ? 16 : 8) & 0xFF
        let blue = hex >> (containsOpacity ? 8 : 0) & 0xFF
        let opacity = containsOpacity ? hex & 0xFF : 255
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0, opacity: Double(opacity) / 255.0)
    }
}
