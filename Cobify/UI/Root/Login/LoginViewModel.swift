//
//  LoginViewModel.swift
//  Cobify
//
//  Created by Bruno Bencevic on 17.11.2022..
//

import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published private(set) var isEmailValid = true
    @Published var password = ""
    @Published private(set) var isPasswordValid = true
    @Published private(set) var didAttemptAuth = false
    
    @Published private(set) var isTaskRunning = false
    @Published var infoDialog: InfoDialog?
    
    @Binding var authState: AuthState
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let authService = ServiceFactory.authService
    private var persistenceService = ServiceFactory.persistenceService
    
    init(state: Binding<AuthState>) {
        self._authState = state
        
        setupCancellables()
    }
    
    func loginTapped() {
        self.didAttemptAuth = true
        
        guard self.isEmailValid && self.isPasswordValid else {
            withAnimation {
                self.infoDialog = .init(title: "Invalid credentials", message: "Please make sure your email is valid and your password is more than 4 characters long!", okTitle: "OK", action: {})
            }
            return
        }
        
        startTask()
        
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            do {
                let token = try await self.authService.login(email: self.email, password: self.password)
                self.endTask()
                
                self.authState = .loggedIn
            } catch {
                self.endTask()
                self.showAuthFail(what: "Logging in", error: error)
            }
        }
    }
    
    func registerTapped() {
        self.didAttemptAuth = true
        
        guard self.isEmailValid && self.isPasswordValid else {
            withAnimation {
                self.infoDialog = .init(title: "Invalid credentials", message: "Please make sure your email is valid and your password is more than 4 characters long!", okTitle: "OK", action: {})
            }
            return
        }
        startTask()
        
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            do {
                try await self.authService.register(email: self.email, password: self.password)
                self.endTask()
                
                self.authState = .loggedIn
            } catch {
                self.endTask()
                self.showAuthFail(what: "Registration", error: error)
            }
            
            self.isTaskRunning = false
        }
    }
}

private extension LoginViewModel {
    
    func startTask() {
        withAnimation {
            self.isTaskRunning = true
        }
    }
    
    func endTask() {
        withAnimation {
            self.isTaskRunning = false
        }
    }
    
    func setupCancellables() {
        self._email.projectedValue
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.validateEmail()
            }
            .store(in: &cancellables)
        
        self._password.projectedValue
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.validatePassword()
            }
            .store(in: &cancellables)
    }
    
    func validateEmail() {
        withAnimation {
            self.isEmailValid = self.email.count >= 4
        }
    }
    
    func validatePassword() {
        withAnimation {
            self.isPasswordValid = self.password.count >= 4
        }
    }
    
    func showAuthFail(what: String, error: Error) {
        withAnimation {
            self.infoDialog = .init(title: "\(what) failed", message: "Please try again later (error: \(error.localizedDescription)", okTitle: "OK", action: {})
        }
    }
}
