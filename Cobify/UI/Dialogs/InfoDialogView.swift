//
//  InfoDialogView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 08.12.2022..
//

import SwiftUI

struct InfoDialog {
    let title: String
    let message: String
    let okTitle: String
    let action: EmptyCallback
    
    static var sample: InfoDialog {
        .init(title: "This is a sample message", message: "Tap OK to dismiss", okTitle: "OK", action: {})
    }
}

extension View {
    
    func infoDialog(dialog dialogBinding: Binding<InfoDialog?>) -> some View {
        ZStack(alignment: .bottom) {
            self
            
            if let dialog = dialogBinding.wrappedValue {
                ZStack {
                    BlurredView(style: .light)
                        .ignoresSafeArea(.all)
                    
                    InfoDialogView(isVisible: .init(get: {
                        dialogBinding.wrappedValue != nil
                    }, set: { newValue in
                        guard !newValue else { return }
                        dialogBinding.wrappedValue = nil
                    }), dialog: dialog)
                    
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

struct InfoDialogView: View {
    
    @Binding var isVisible: Bool
    let dialog: InfoDialog
    
    var body: some View {
        VStack(spacing: 16) {
            Text(dialog.title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(dialog.message)
                .font(.title3)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            button(dialog.okTitle, bold: true) {
                withAnimation {
                    isVisible = false
                }
                
                dialog.action()
            }
            .shadow(radius: 10)
            .padding(.top, 8)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(BlurredView(style: .light))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 10)
        .padding(.horizontal, 12)
        .padding(.bottom, UIScreen.bottomUnsafePadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

private extension InfoDialogView {
    
    func button(_ title: String, bold: Bool, action: @escaping EmptyCallback) -> some View {
        Text(title)
            .font(.title3)
            .fontWeight(bold ? .bold : .medium)
            .frame(maxWidth: .infinity, height: 60)
            .background(BlurredView(style: .light))
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                action()
            }
    }
}

struct InfoDialogView_Previews: PreviewProvider {
    
    static var previews: some View {
        InfoDialogView(isVisible: .constant(true), dialog: .sample)
            .background(
                Image("placeholder_panda")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
    }
}
