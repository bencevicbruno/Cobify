//
//  SplashView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 09.01.2023..
//

import SwiftUI

struct SplashView: View {
    
    @Binding var state: AuthState
    
    @State private var didAppear = false
    @State private var didAppear1 = false
    @State private var didAppear2 = false
    @State private var didAppear3 = false
    @State private var didAppear4 = false
    
    private let audioService = ServiceFactory.audioService
    private let persistenceService = ServiceFactory.persistenceService
    
    var body: some View {
        VStack {
            Text("COBIFY")
                .minimumScaleFactor(0.01)
                .font(.system(size: didAppear ? 66 : 56))
                .frame(height: UIScreen.height * 0.33)
            
            HStack {
                Text("Jesi ")
                    .foregroundColor(didAppear1 ? .cobifyOnyx : .white)
                    .font(.system(size: 32))
                
                +
                
                Text("ti ")
                    .foregroundColor(didAppear2 ? .cobifyOnyx : .white)
                    .font(.system(size: 32))
                
                +
                
                Text("radio ")
                    .foregroundColor(didAppear3 ? .cobifyOnyx : .white)
                    .font(.system(size: 32))
            }
            
            Text("traku?")
                .foregroundColor(didAppear4 ? .cobifyOnyx : .white)
                .font(.system(size: 42))
            
        }
        .lineLimit(1)
        .fontWeight(.heavy)
        .foregroundColor(.cobifyOnyx)
        .frame(width: UIScreen.width * 0.7)
        .onAppear {
            withAnimation(.spring().repeatForever(autoreverses: true)) {
                didAppear = true
            }
            
            matchAnimationsToSound()
            
            let duration = try? audioService.playFromBundle()
            DispatchQueue.main.asyncAfter(deadline: .now() + (duration ?? 1)) {
                withAnimation {
                    state = persistenceService.authToken == nil ? .loggedOut : .loggedIn
                }
            }
        }
    }
    
    func matchAnimationsToSound() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            didAppear1 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            didAppear2 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
            didAppear3 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
            didAppear4 = true
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    
    static var previews: some View {
        SplashView(state: .constant(.splash))
    }
}
