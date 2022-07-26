//
//  MoyaProvider+RequestAsync.swift
//  MyAnime
//
//  Created by Garry on 27/06/22.
//

import Foundation
import Moya

extension MoyaProvider {
    func requestAsync<T: Codable>(_ target: Target, model: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation({ continuation in
            self.request(target) { result in
                switch result {
                case .failure(let moyaError):
                    continuation.resume(throwing: moyaError)
                case .success(let response):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    do {
                        let decodeData = try jsonDecoder.decode(model.self, from: response.data)
                        continuation.resume(returning: decodeData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        })
    }
}
