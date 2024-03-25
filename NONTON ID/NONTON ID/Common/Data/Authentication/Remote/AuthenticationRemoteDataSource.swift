//
//  AuthenticationRemoteDataSource.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.
//

import Foundation
import Firebase

protocol AuthenticationRemoteDataSource {
    func createUser(with email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void)
    func loginUser(with email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void)
    func storeUserData(email: String, username: String, completion: @escaping (Error?) -> Void)
}
