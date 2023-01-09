//
//  BackendTestView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 12.12.2022..
//

import SwiftUI

struct BackendTestView: View {
    
    let audioService = AudioService()
    
    var body: some View {
        VStack(spacing: 20) {
            Button("test") {
                do {
                    try audioService.playFromBundle()
                } catch {
                    print("error: \(error)")
                }
                
                
            }
            
            Button("pause") {
                audioService.pauseSound()
            }
            
            Button("resume") {
                audioService.resumeSound()
            }
            
            Button("stop") {
                audioService.stopSound()
            }
//            let backend = BackendAPI(backendID: "e9e4-213-149-61-191")
//            backend.fetchSong(byID: 13)
        }
        .font(.largeTitle)
    }
}

struct BackendTestView_Previews: PreviewProvider {
    
    static var previews: some View {
        BackendTestView()
    }
}
