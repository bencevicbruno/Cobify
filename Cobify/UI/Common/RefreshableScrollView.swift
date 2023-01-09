//
//  RefreshableScrollView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import SwiftUI

struct RefreshableScrollView<T: View>: View {
    
    let axes: Axis.Set
    let showsIndicators: Bool
    let content: T
    let onRefresh: EmptyCallback
    
    init(axes: Axis.Set = .vertical,
         showsIndicators: Bool = true,
         @ViewBuilder content: () -> T,
         onRefresh: @escaping EmptyCallback = {}) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            GeometryReader { proxy in
                Color.clear
                    .preference(
                        key: OffsetPreferenceKey.self,
                        value: proxy.frame(in: .named("ScrollViewOrigin")).origin
                    )
            }
            .frame(width: 0, height: 0)
            
            content
        }
        .coordinateSpace(name: "ScrollViewOrigin")
        .onPreferenceChange(OffsetPreferenceKey.self) { offset in
            guard offset.y > UIScreen.height / 4 else { return }
            onRefresh()
        }
    }
}

private struct OffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}
