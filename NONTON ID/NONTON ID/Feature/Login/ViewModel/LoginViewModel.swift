//
//  LoginViewModel.swift
//  NONTON ID
//
//  Created by Garry on 16/07/22.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    
    private let authenticationRepository: AuthenticationRepository
    
    @AppStorage("language") var language = NONTON_ID.LocalizationService.shared.language
    @AppStorage("loginStatus") var loginStatus = false
    @Published var isSignUpView = false
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var isDisabled = true
    @Published var isHidden = true
    
    init(
        authenticationRepository: AuthenticationRepository = AuthenticationDefaultRepository()
    ) {
        self.authenticationRepository = authenticationRepository
    }
    
    @MainActor func onStartFetch() {
        self.isError = false
        self.errorMessage = ""
        self.isDisabled = true
    }
    
    func handleAction() {
        Task {
            await onStartFetch()
            if isSignUpView == false {
                loginUser()
            } else {
                createAccount()
            }
        }
    }
    
    func createAccount() {
        authenticationRepository.provideCreateUser(with: email, password: password) { [weak self] error in
            DispatchQueue.main.async { [weak self] in
                self?.isError = false
                self?.storeUserData()
                self?.loginUser()
                self?.isError = true
                self?.errorMessage = (error?.localizedDescription).orEmpty()
            }
        }
    }
    
    func loginUser() {
        authenticationRepository.provideLoginUser(with: email, password: password) { [weak self] error in
            DispatchQueue.main.async { [weak self] in
                withAnimation {
                    self?.loginStatus = true
                }
                
                self?.isError = true
                self?.errorMessage = (error?.localizedDescription).orEmpty()
            }
        }
    }
    
    private func storeUserData() {
        authenticationRepository.provideStoreUserData(email: email, username: username) { [weak self] error in
            DispatchQueue.main.async { [weak self] in
                self?.isError = true
                self?.errorMessage = (error?.localizedDescription).orEmpty()
            }
        }
    }
    
    func activateButton() {
        if isSignUpView {
            if email != "" && password != "" && username != "" {
                self.isDisabled = false
            } else {
                self.isDisabled = true
            }
        } else {
            if email != "" && password != "" {
                self.isDisabled = false
            } else {
                self.isDisabled = true
            }
        }
    }
    
    func loginSignUpToggle() {
        self.isSignUpView.toggle()
    }
    
    func hidePasswordToggle() {
        self.isHidden.toggle()
    }
}
