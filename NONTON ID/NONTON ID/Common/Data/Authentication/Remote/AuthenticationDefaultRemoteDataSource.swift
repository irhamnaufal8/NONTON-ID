//
//  AuthenticationDefaultRemoteDataSource.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.
//

import Foundation
import Firebase

final class AuthenticationDefaultRemoteDataSource: AuthenticationRemoteDataSource {
    func createUser(with email: String, password: String) throws {
        var errorMessage = ""
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                print(errorMessage)
                return
            }
        }
    }
    
    func loginUser(with email: String, password: String) throws {
        var errorMessage = ""
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                print(errorMessage)
                return
            }

            errorMessage = "Successfully log in as user: \(result?.user.uid ?? "")"
            print(errorMessage)
        }
    }
    
    func storeUserData(email: String, username: String) throws {
        var errorMessage = ""
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = User(id: uid, email: email, username: username).toJSON()

        Firestore.firestore().collection("users")
            .document(uid)
            .setData(userData) { error in
                if let error = error {
                    errorMessage = error.localizedDescription
                    print(errorMessage)
                    return
                }

                errorMessage = "Successfully store user data"
                print(errorMessage)
            }
    }
}
