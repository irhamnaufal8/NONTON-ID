//
//  AuthenticationRepository.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.


import Foundation

protocol AuthenticationRepository {
    func provideCreateUser(with email: String, password: String, completion: @escaping (Error?) -> Void)
    func provideLoginUser(with email: String, password: String, completion: @escaping (Error?) -> Void)
    func provideStoreUserData(email: String, username: String, completion: @escaping (Error?) -> Void)
}
