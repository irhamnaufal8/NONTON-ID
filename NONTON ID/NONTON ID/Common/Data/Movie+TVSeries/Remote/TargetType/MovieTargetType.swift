//
//  MovieTargetType.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.
//

import Foundation
import Moya

enum MovieTargetType {
    case getTrendingMovie
    case getMovieDetail(Int)
    case getTrendingTVSeries
}

extension MovieTargetType: NontonIDTargetType, AccessTokenAuthorizable {
    var authorizationType: Moya.AuthorizationType? {
        return .bearer
    }
    
    var parameters: [String : Any] {
        return [:]
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        URLEncoding.default
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
    
    var path: String {
        
        switch self {
        case .getTrendingMovie:
            return "/trending/movie/day"
        case .getMovieDetail(let movieID):
            return "/movie/\(movieID)"
        case .getTrendingTVSeries:
            return "/trending/tv/day"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTrendingMovie:
            return .get
        case .getMovieDetail:
            return .get
        case .getTrendingTVSeries:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
