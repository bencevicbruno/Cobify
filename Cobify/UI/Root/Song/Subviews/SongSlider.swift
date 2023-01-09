//
//  SongSlider.swift
//  Cobify
//
//  Created by Bruno Bencevic on 18.11.2022..
//

import SwiftUI

struct SongSlider: View {
    
    @Binding private var progress: Double
    @State private var size: CGSize = .zero
    
    init(progress: Binding<Double>) {
        self._progress = progress
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                BlurredView(style: .light)
                    .frame(height: 8)
                    .clipShape(Capsule())
                
                Capsule()
                    .fill(.white)
                    .frame(width: CGFloat(progress) * size.width, height: 8)
            }
            .frame(height: 10)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .named(Self.coordinateNamespace))
                    .onChanged { value in
                        let percentage = min(max(0, value.location.x / size.width), 1)
                        
                        withAnimation(.linear(duration: 0.05)) {
                            self.progress = Double(percentage)
                        }
                        
                        print(progress)
                    })
            .readSize(into: $size)
            
            Circle()
                .fill(.white)
                .frame(size: 15)
                .padding(.leading, max(0, CGFloat(progress) * size.width - 15))
                .allowsHitTesting(false)
        }
    }
    
    private static let coordinateNamespace = "SongSlider"
}

struct SongSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        @State var progress: Double = 0.0
        
        return SongSlider(progress: $progress)
            .background(
                ZStack {
                    Image("placeholder_panda")
                        .resizable()
                        .scaledToFill()
                    
                    BlurredView(style: .dark)
                }
            )
    }
}
