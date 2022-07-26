//
//  AuthenticationRemoteDataSource.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.
//

import Foundation

protocol AuthenticationRemoteDataSource {
    func createUser(with email: String, password: String) throws
    func loginUser(with email: String, password: String) throws
    func storeUserData(email: String, username: String) throws
}
