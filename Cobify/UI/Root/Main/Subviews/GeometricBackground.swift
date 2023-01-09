//
//  GeometricBackground.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import SwiftUI

struct GeometricBackground: View {
    
    var body: some View {
        GeometryReader { proxy in
            mozaic(width: proxy.size.width, height: proxy.size.height)
        }
        .aspectRatio(0.55, contentMode: .fill)
        .blur(radius: 15)
    }
}

private extension GeometricBackground {
    
    func mozaic(width: CGFloat, height: CGFloat) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.cobifyOnyx)
                .frame(size: width * 0.5)
                .rotationEffect(.degrees(25))
                .offset(x: width * 0.1, y: height * 0.3)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.cobifySunray)
                .frame(size: width * 0.55)
                .rotationEffect(.degrees(15))
                .offset(x: width * 0.6, y: height * 0.6)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.cobifyAlabaster)
                .frame(size: width * 0.45)
                .rotationEffect(.degrees(35))
                .offset(x: width * 0.9, y: height * 0.25)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.cobifyFireOpal)
                .frame(size: width * 0.35)
                .rotationEffect(.degrees(45))
                .offset(x: -15, y: 15)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.cobifyAlabaster)
                .frame(size: width * 0.65)
                .rotationEffect(.degrees(55))
                .offset(x: 0, y: height * 0.8)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.cobifyFireOpal)
                .frame(size: width * 0.15)
                .rotationEffect(.degrees(65))
                .offset(x: width * 0.55, y: height * 0.55)
                .zIndex(236)
        }
    }
}

struct GeometricBackground_Previews: PreviewProvider {
    
    static var previews: some View {
        GeometricBackground()
            .edgesIgnoringSafeArea(.all)
    }
}
