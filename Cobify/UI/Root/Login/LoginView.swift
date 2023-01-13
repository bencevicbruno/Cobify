//
//  LoginView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 17.11.2022..
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel: LoginViewModel
    
    @FocusState private var isEmailFieldInFocus
    @FocusState private var isPasswordFieldInFocus
    
    init(state: Binding<AuthState>) {
        self._viewModel = .init(wrappedValue: LoginViewModel(state: state))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                Spacer()
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Welcome to")
                        .lineLimit(1)
//                        .fontWeight(.heavy)
                        .minimumScaleFactor(0.01)
                    
                    Text("COBIFY")
                        .lineLimit(1)
//                        .fontWeight(.heavy)
                        .minimumScaleFactor(0.01)
                }
                .font(.system(size: 56))
                .foregroundColor(.cobifyOnyx)
                .frame(width: UIScreen.width * 0.7)
                
                Spacer()
                
                Spacer()
            }
            
            InputField(name: "Email", text: $viewModel.email, isInFocus: _isEmailFieldInFocus, showError: !viewModel.isEmailValid && viewModel.didAttemptAuth)
                .padding(.bottom, 12)
            
            InputField(name: "Password", text: $viewModel.password, isInFocus: _isPasswordFieldInFocus, showError: !viewModel.isPasswordValid && viewModel.didAttemptAuth)
                .padding(.bottom, 48)
            
            BigButton("LOGIN") {
                isEmailFieldInFocus = false
                isPasswordFieldInFocus = false
                viewModel.loginTapped()
            }
            .padding(.bottom, 12)
            
            registerCaption
                
            Spacer(minLength: 12)
        }
        .padding(.horizontal, 12)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isEmailFieldInFocus = false
                isPasswordFieldInFocus = false
            }
        }
        .overlay {
            LoadingOverlay(isVisible: viewModel.isTaskRunning)
                .edgesIgnoringSafeArea(.all)
        }
        .infoDialog(dialog: $viewModel.infoDialog)
    }
}

private extension LoginView {
    
    var registerCaption: some View {
        HStack {
            Text("OR ")
                .font(.system(size: 24))
                .foregroundColor(.cobifyOnyx)
            +
            
            Text("REGISTER")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(.cobifySunray)
            
            +
            
            Text(" HERE")
                .font(.system(size: 24))
                .foregroundColor(.cobifyOnyx)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isEmailFieldInFocus = false
            isPasswordFieldInFocus = false
            viewModel.registerTapped()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        @State var authState = AuthState.loggedOut
        
        return LoginView(state: $authState)
    }
}
