//
//  AuthenticationDefaultRepository.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.
//

import Foundation
import Firebase

final class AuthenticationDefaultRepository: AuthenticationRepository {
    private let remote: AuthenticationRemoteDataSource
    
    init(
        remote: AuthenticationRemoteDataSource = AuthenticationDefaultRemoteDataSource()
    ) {
        self.remote = remote
    }
    
    func provideCreateUser(with email: String, password: String) throws {
        try self.remote.createUser(with: email, password: password)
    }
    
    func provideLoginUser(with email: String, password: String) throws {
        try self.remote.loginUser(with: email, password: password)
    }
    
    func provideStoreUserData(email: String, username: String) throws {
        try self.remote.storeUserData(email: email, username: username)
    }
}
