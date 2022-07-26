//
//  NontonIDTargetType.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.
//

import Foundation
import Moya

protocol NontonIDTargetType: TargetType {
    var parameters: [String: Any] {
        get
    }
}

extension NontonIDTargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3") ?? (NSURL() as URL)
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        JSONEncoding.default
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
