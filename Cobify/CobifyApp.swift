//
//  CobifyApp.swift
//  Cobify
//
//  Created by Bruno Bencevic on 16.11.2022..
//

import SwiftUI

@main
struct CobifyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            BackendTestView()
            RootView()
                .preferredColorScheme(.light)
        }
    }
}
