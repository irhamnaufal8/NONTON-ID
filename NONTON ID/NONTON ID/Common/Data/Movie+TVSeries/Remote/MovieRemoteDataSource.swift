//
//  MovieRemoteDataSource.swift
//  NONTON ID
//
//  Created by Garry on 21/07/22.
//

import Foundation

protocol MovieRemoteDataSource {
    func getTrendingMovie() async throws -> ArrayResult<Movie>
    func getMovieDetail(by movieId: Int) async throws -> Movie
    func getTrendingTVSeries() async throws -> ArrayResult<TVSeries>
}
