//
//  AuthenticationDefaultRepository.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.
//

import Foundation

final class AuthenticationDefaultRepository: AuthenticationRepository {
    private let remote: AuthenticationRemoteDataSource
    
    init(
        remote: AuthenticationRemoteDataSource = AuthenticationDefaultRemoteDataSource()
    ) {
        self.remote = remote
    }
    
    func provideCreateUser(with email: String, password: String, completion: @escaping (Error?) -> Void) {
        remote.createUser(with: email, password: password) { _, error in
            completion(error)
        }
    }
    
    func provideLoginUser(with email: String, password: String, completion: @escaping (Error?) -> Void) {
        remote.loginUser(with: email, password: password) { _, error in
            completion(error)
        }
    }
    
    func provideStoreUserData(email: String, username: String, completion: @escaping (Error?) -> Void) {
        remote.storeUserData(email: email, username: username, completion: completion)
    }
}
