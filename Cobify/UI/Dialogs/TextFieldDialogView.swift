//
//  TextFieldDialogView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 08.12.2022..
//

import SwiftUI

struct TextFieldDialog {
    let title: String
    let message: String
    let confirmTitle: String
    let cancelTitle: String
    let confirmAction: EmptyCallback
    let cancelAction: EmptyCallback
    
    static var sample: TextFieldDialog {
        .init(title: "Are you sure you want to log out?", message: "You can login back at any time you want.", confirmTitle: "Log Out", cancelTitle: "Cancel", confirmAction: {}, cancelAction: {})
    }
}

extension View {
    
    func textFieldDialog(dialog dialogBinding: Binding<TextFieldDialog?>) -> some View {
        ZStack(alignment: .bottom) {
            self
            
            if let dialog = dialogBinding.wrappedValue {
                ZStack {
                    BlurredView(style: .light)
                        .ignoresSafeArea(.all)
                    
                    TextFieldDialogView(isVisible: .init(get: {
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

struct TextFieldDialogView: View {
    
    @Binding var isVisible: Bool
    let dialog: TextFieldDialog
    
    @State private var text = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Text(dialog.title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            
            ZStack {
                BlurredView(style: .light)
                
                TextField("Tap to start typing...", text: $text)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.horizontal, 12)
                    .frame(maxWidth: .infinity, height: 50)
                    .clipShape(Rectangle())
            }
            .frame(height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            HStack(spacing: 16) {
                button(dialog.cancelTitle, bold: false) {
                    withAnimation {
                        isVisible = false
                    }
                    
                    dialog.cancelAction()
                }
                .shadow(radius: 10)
                
                button(dialog.confirmTitle, bold: true) {
                    withAnimation {
                        isVisible = false
                    }
                    
                    dialog.confirmAction()
                }
                .shadow(radius: 10)
            }
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

private extension TextFieldDialogView {
    
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

struct TextFieldDialogView_Previews: PreviewProvider {
    
    static var previews: some View {
        TextFieldDialogView(isVisible: .constant(true), dialog: .sample)
            .background(
                Image("placeholder_panda")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
    }
}
