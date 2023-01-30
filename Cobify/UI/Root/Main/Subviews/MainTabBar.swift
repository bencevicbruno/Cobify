//
//  MainTabBar.swift
//  Cobify
//
//  Created by Bruno Bencevic on 20.11.2022..
//

import SwiftUI

struct MainTabBar: View {
    
    @Binding var currentTab: MainTab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases) { tab in
                tabBarItem(for: tab)
            }
        }
        .padding(.vertical, 4)
        .background(
            BlurredView(style: .light)
                .tint(Color.cobifyPlatinum)
        )
    }
    
    func tabBarItem(for tab: MainTab) -> some View {
        VStack(spacing: 2) {
            Image(systemName: tab.systemImageName)
                .resizable()
                .scaledToFit()
                .frame(size: 24)
            
            Text(tab.title)
        }
        .fontWeight(currentTab == tab ? .medium : .regular)
        .foregroundColor(currentTab == tab ? .cobifyFireOpal : .cobifyOnyx)
        .frame(maxWidth: .infinity)
        .frame(height: Self.height)
        .frame(height: Self.totalHeight, alignment: .top)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                currentTab = tab
            }
        }
    }
    
    static let height: CGFloat = 60
    static let totalHeight: CGFloat = 60 + UIScreen.bottomUnsafePadding
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        @State var tab: MainTab = .home
        
        return MainTabBar(currentTab: $tab)
    }
}
