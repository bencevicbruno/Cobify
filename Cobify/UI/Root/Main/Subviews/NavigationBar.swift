//
//  NavigationBar.swift
//  Cobify
//
//  Created by Bruno Bencevic on 28.11.2022..
//

import SwiftUI

struct NavigationBar: View {
    
    private let title: String
    private let iconImageName: String
    private let onIconTapped: EmptyCallback
    private let containsBottomPadding: Bool
    
    init(_ title: String, icon: String, containsBottomPadding: Bool = false, onTapped: @escaping EmptyCallback = {}) {
        self.title = title
        self.iconImageName = icon
        self.onIconTapped = onTapped
        self.containsBottomPadding = containsBottomPadding
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
            
            if iconImageName != "" {
                Icon(iconImageName, iconSize: 36, frameSize: 44) {
                    onIconTapped()
                }
            }
        }
        .foregroundColor(Color.cobifyOnyx)
        .padding([.bottom, .horizontal], 12)
        .frame(height: Self.totalHeight, alignment: .bottom)
        .padding(.bottom, containsBottomPadding ? Self.bottomPadding : 0)
        .background(
            BlurredView(style: .light)
                .tint(Color.cobifyPlatinum)
        )
    }
    
    static let height: CGFloat = 80
    static let totalHeight: CGFloat = Self.height + UIScreen.topUnsafePadding
    static let bottomPadding: CGFloat = 60
}

struct NavigationBar_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            NavigationBar("MyHome", icon: "person.circle", containsBottomPadding: true)
            
            NavigationBar("MyHome", icon: "person.circle", containsBottomPadding: false)
        }
    }
}
