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

extension MovieTargetType: NontonIDTargetType {
    var parameters: [String : Any] {
        let apiKey: String = "35085a91df1b7d52c276b7f1f1848e60"
        return ["api_key": "\(apiKey)"]
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
        switch self {
        case .getTrendingMovie:
            let response = TrendingMovie(
                results: [
                    Movie(
                        id: 1,
                        originalTitle: "Sample Title",
                        overview: "This is sample title.",
                        posterPath: "https://image.com/image.jpg"
                    )
                ]
            )
            return response.toJSONData()
            
        case .getMovieDetail(let movieID):
            let response = Movie(
                id: movieID,
                originalTitle: "Sample Title",
                overview: "This is sample title.",
                posterPath: "https://image.com/image.jpg"
            )
            return response.toJSONData()
        case .getTrendingTVSeries:
            let response = TrendingTV(
                results: [
                    TVSeries(
                        id: 1,
                        name: "Sample Title",
                        overview: "This is sample title.",
                        posterPath: "https://image.com/image.jpg",
                        backdropPath: "https://image.com/image.jpg"
                    )
                ]
            )
            return response.toJSONData()
        }
    }
}
