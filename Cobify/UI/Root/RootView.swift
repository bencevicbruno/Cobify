//
//  RootView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 20.11.2022..
//

import SwiftUI

enum AuthState {
    case splash
    case loggedOut
    case loggedIn
}

struct RootView: View {
    
    @State private var state: AuthState = .splash
    
    init() {
        
    }
    
    var body: some View {
        switch state {
        case .splash:
            SplashView(state: $state)
        case .loggedOut:
            LoginView(state: $state)
        case .loggedIn:
            MainView(authState: $state)
                .transition(.move(edge: .trailing))
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    
    static var previews: some View {
        RootView()
    }
}
