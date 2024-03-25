//
//  AuthenticationDefaultRemoteDataSource.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.
//

import Foundation
import Firebase

final class AuthenticationDefaultRemoteDataSource: AuthenticationRemoteDataSource {
    func createUser(with email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func loginUser(with email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func storeUserData(email: String, username: String, completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = User(id: uid, email: email, username: username).toJSON()

        Firestore.firestore().collection("users")
            .document(uid)
            .setData(userData, completion: completion)
    }
}
