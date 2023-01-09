//
//  RootView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 20.11.2022..
//

import SwiftUI

enum AuthState {
    case loggedOut
    case loggedIn
}

struct RootView: View {
    
    @State private var state: AuthState
    
    init() {
        self._state = .init(wrappedValue: ServiceFactory.persistenceService.authToken == nil ? .loggedOut : .loggedIn)
    }
    
    var body: some View {
        switch state {
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
