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
    @AppStorage("language") var language = NONTON_ID.LocalizationService.shared.language
    
    @Published var isSignUpView = false
    @Published var email = ""
    @Published var password = ""
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var isDisabled = true
    
//    init() {
//        FirebaseApp.configure()
//    }
    
    @MainActor func onStartFetch() {
        self.isError = false
        self.errorMessage = ""
        self.isDisabled = true
    }
    
    func handleAction() {
        if isSignUpView == false {
            loginUser()
        } else {
            createAccount()
        }
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                self.isError = true
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
                return
            }
            
            self.isError = false
            self.errorMessage = "Successfully created user: \(result?.user.uid ?? "")"
            print(self.errorMessage)
        }
    }
    
    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                self.isError = true
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
                return
            }
            
            self.isError = false
            self.errorMessage = "Successfully log in as user: \(result?.user.uid ?? "")"
            print(self.errorMessage)
        }
    }
    
    func disableButton() {
        if email != "" && password != "" {
            self.isDisabled = false
        } else {
            self.isDisabled = true
        }
    }
}
