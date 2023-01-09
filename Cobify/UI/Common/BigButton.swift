//
//  BigButton.swift
//  Cobify
//
//  Created by Bruno Bencevic on 28.11.2022..
//

import SwiftUI

struct BigButton: View {
    
    let title: String
    let onTapped: EmptyCallback
    let textColor: Color
    let buttonColor: Color
    
    init(_ title: String, _ onTapped: @escaping EmptyCallback = {}, textColor: Color = .white, buttonColor: Color = .cobifySunray) {
        self.title = title
        self.onTapped = onTapped
        self.textColor = textColor
        self.buttonColor = buttonColor
    }
    
    var body: some View {
        Text(title.uppercased())
            .font(.title)
            .fontWeight(.bold)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(buttonColor)
            .foregroundColor(textColor)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .contentShape(RoundedRectangle(cornerRadius: 15))
            .onTapGesture {
                onTapped()
            }
    }
}

struct BigButton_Previews: PreviewProvider {
    
    static var previews: some View {
        BigButton("bUtOn")
    }
}
