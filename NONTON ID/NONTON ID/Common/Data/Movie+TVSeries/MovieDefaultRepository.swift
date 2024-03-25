//
//  MovieDefaultRepository.swift
//  NONTON ID
//
//  Created by Garry on 21/07/22.
//

import Foundation
import Moya

final class MovieDefaultRepository: MovieRepository {
    private let remote: MovieRemoteDataSource
    private let local: MovieLocalDataSource
    
    init(
        remote: MovieRemoteDataSource = MovieDefaultRemoteDataSource(),
        local: MovieLocalDataSource = MovieDefaultLocalDataSource()
    ) {
        self.remote = remote
        self.local = local
    }
    
    func provideGetTrendingMovie() async throws -> ArrayResult<Movie> {
        try await self.remote.getTrendingMovie()
    }
    
    func provideGetMovieDetail(by movieId: Int) async throws -> Movie {
        try await self.remote.getMovieDetail(by: movieId)
    }
    
    func provideGetTrendingTVSeries() async throws -> ArrayResult<TVSeries> {
        try await self.remote.getTrendingTVSeries()
    }
    
    func provideSaveToLocalMovieList(by movie: Movie) throws {
        try self.local.saveToLocalMovieList(by: movie)
    }
    
    func provideLoadLocalMovie() async throws -> [MovieData] {
        try await self.local.loadLocalMovie()
    }
    
    func provideDeleteLocalItem() throws {
        try self.local.deleteLocalItem()
    }
    
    func provideToggleFavorite(by movie: MovieData) throws {
        try self.local.toggleFavorite(by: movie)
    }
    
    func provideSaveToLocalTVList(by tv: TVSeries) throws {
        try self.local.saveToLocalTVList(by: tv)
    }
    
    func provideLoadLocalTV() async throws -> [TVData] {
        try await self.local.loadLocalTV()
    }
    
    func provideDeleteLocalTV() throws {
        try self.local.deleteLocalTV()
    }
    
    func provideToggleFavoriteTV(by tv: TVData) throws {
        try self.local.toggleFavoriteTV(by: tv)
    }
}
