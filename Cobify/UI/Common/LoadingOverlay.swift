//
//  LoadingOverlay.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import SwiftUI

struct LoadingOverlay: View {
    
    let isVisible: Bool
    
    @State private var didAppear = false
    
    var body: some View {
        HStack(spacing: 24) {
            circle(delay: 0)
            
            circle(delay: 0.15)
            
            circle(delay: 0.30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            BlurredView(style: .dark)
                .opacity(0.33)
        )
        .opacity(isVisible ? 1 : 0)
        .allowsHitTesting(isVisible)
        .onAppear {
            didAppear = true
        }
    }
}

private extension LoadingOverlay {
    
    func circle(delay: Double) -> some View {
        Circle()
            .fill(.white)
            .shadow(radius: 10)
            .frame(size: didAppear ? 25 : 40)
            .animation(.linear(duration: 0.45).repeatForever(autoreverses: true).delay(delay), value: didAppear)
            .frame(size: 40)
    }
}

struct LoadingOverlay_Previews: PreviewProvider {
    
    static var previews: some View {
        LoadingOverlay(isVisible: true)
            .edgesIgnoringSafeArea(.all)
            .background(.blue)
    }
}
