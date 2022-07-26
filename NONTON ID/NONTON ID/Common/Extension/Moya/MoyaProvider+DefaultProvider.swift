//
//  MoyaProvider+DefaultProvider.swift
//  MyAnime
//
//  Created by Garry on 27/06/22.
//

import Foundation
import Moya

extension MoyaProvider {
    static func defaultProvider() -> MoyaProvider {
        return MoyaProvider(plugins: [NetworkLoggerPlugin()])
    }
}
