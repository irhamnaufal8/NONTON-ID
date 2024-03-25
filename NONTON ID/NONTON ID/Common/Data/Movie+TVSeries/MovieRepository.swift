//
//  MovieRepository.swift
//  NONTON ID
//
//  Created by Garry on 21/07/22.
//

import Foundation

protocol MovieRepository {
    func provideGetTrendingMovie() async throws -> ArrayResult<Movie>
    func provideGetMovieDetail(by movieId: Int) async throws -> Movie
    func provideGetTrendingTVSeries() async throws -> ArrayResult<TVSeries>
    func provideSaveToLocalMovieList(by movie: Movie) throws
    func provideLoadLocalMovie() async throws -> [MovieData]
    func provideDeleteLocalItem() throws
    func provideToggleFavorite(by movie: MovieData) throws
    func provideSaveToLocalTVList(by tv: TVSeries) throws
    func provideLoadLocalTV() async throws -> [TVData]
    func provideDeleteLocalTV() throws
    func provideToggleFavoriteTV(by tv: TVData) throws
}
