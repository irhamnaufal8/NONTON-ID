//
//  LoginViewModel.swift
//  NONTON ID
//
//  Created by Garry on 16/07/22.
//

import Foundation
import SwiftUI
import Firebase

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
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            if let error = error {
//                self.isError = true
//                self.errorMessage = error.localizedDescription
//                print(self.errorMessage)
//                return
//            }
//
//            self.isError = false
//            self.storeUserData()
//            self.loginUser()
//
//        }
        
        do {
            try authenticationRepository.provideCreateUser(with: self.email, password: self.password)

            DispatchQueue.main.async { [weak self] in
                self?.isError = false
                self?.storeUserData()
                self?.loginUser()
            }

        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.isError = true
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func loginUser() {
//        Auth.auth().signIn(withEmail: email, password: password) { result, error in
//            if let error = error {
//                self.isError = true
//                self.errorMessage = error.localizedDescription
//                print(self.errorMessage)
//                return
//            }
//
//            self.isError = false
//            self.errorMessage = "Successfully log in as user: \(result?.user.uid ?? "")"
//            print(self.errorMessage)
//
//            withAnimation {
//                self.loginStatus = true
//            }
//        }
        
        do {
            try authenticationRepository.provideLoginUser(with: self.email, password: self.password)
            
            DispatchQueue.main.async { [weak self] in
                withAnimation {
                    self?.loginStatus = true
                }
            }
            
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.isError = true
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func storeUserData() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let userData = User(id: uid, email: self.email, username: self.username).toJSON()
//
//        Firestore.firestore().collection("users")
//            .document(uid)
//            .setData(userData) { error in
//                if let error = error {
//                    self.isError = true
//                    self.errorMessage = error.localizedDescription
//                    print(self.errorMessage)
//                    return
//                }
//
//                self.isError = false
//                self.errorMessage = "Successfully store user data"
//                print(self.errorMessage)
//            }
        
        do {
            try authenticationRepository.provideStoreUserData(email: self.email, username: self.username)
            
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.isError = true
                self?.errorMessage = error.localizedDescription
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
