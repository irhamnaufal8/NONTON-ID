//
//  MovieDefaultRemoteDataSource.swift
//  NONTON ID
//
//  Created by Garry on 21/07/22.
//

import Foundation
import Moya

final class MovieDefaultRemoteDataSource: MovieRemoteDataSource {
    
    private let provider: MoyaProvider<MovieTargetType>
    
    init(provider: MoyaProvider<MovieTargetType> = .defaultProvider()) {
        self.provider = provider
    }
    
    func getTrendingMovie() async throws -> TrendingMovie {
        try await self.provider.requestAsync(.getTrendingMovie, model: TrendingMovie.self)
    }
    
    func getMovieDetail(by movieId: Int) async throws -> Movie {
        try await self.provider.requestAsync(.getMovieDetail(movieId), model: Movie.self)
    }
    
    func getTrendingTVSeries() async throws -> TrendingTV {
        try await self.provider.requestAsync(.getTrendingTVSeries, model: TrendingTV.self)
    }
}
