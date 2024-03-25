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
    
    func getTrendingMovie() async throws -> ArrayResult<Movie> {
        try await self.provider.requestAsync(.getTrendingMovie, model: ArrayResult<Movie>.self)
    }
    
    func getMovieDetail(by movieId: Int) async throws -> Movie {
        try await self.provider.requestAsync(.getMovieDetail(movieId), model: Movie.self)
    }
    
    func getTrendingTVSeries() async throws -> ArrayResult<TVSeries> {
        try await self.provider.requestAsync(.getTrendingTVSeries, model: ArrayResult<TVSeries>.self)
    }
}
