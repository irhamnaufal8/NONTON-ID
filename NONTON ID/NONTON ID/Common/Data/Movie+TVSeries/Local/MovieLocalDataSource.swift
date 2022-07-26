//
//  MovieLocalDataSource.swift
//  NONTON ID
//
//  Created by Garry on 22/07/22.
//

import Foundation
import CoreData

protocol MovieLocalDataSource {
    func saveToLocalMovieList(by movie: Movie) throws
    func loadLocalMovie() async throws -> [MovieData]
    func deleteLocalItem() throws
    func toggleFavorite(by movie: MovieData) throws
    
    func saveToLocalTVList(by tv: TVSeries) throws
    func loadLocalTV() async throws -> [TVData]
    func deleteLocalTV() throws
    func toggleFavoriteTV(by tv: TVData) throws
}
