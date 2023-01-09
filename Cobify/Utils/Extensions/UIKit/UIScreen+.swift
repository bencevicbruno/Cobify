//
//  UIScreen+.swift
//  Cobify
//
//  Created by Bruno Bencevic on 28.11.2022..
//

import UIKit

extension UIScreen {
    
    static var width: CGFloat {
        Self.main.bounds.width
    }
    
    static var height: CGFloat {
        Self.main.bounds.height
    }
    
    static var topUnsafePadding: CGFloat {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.safeAreaInsets.top ?? 0
    }
    
    static var bottomUnsafePadding: CGFloat {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.safeAreaInsets.bottom ?? 0
    }
}
