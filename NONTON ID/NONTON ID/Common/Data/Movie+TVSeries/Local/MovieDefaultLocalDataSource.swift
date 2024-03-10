//
//  MovieDefaultLocalDataSource.swift
//  NONTON ID
//
//  Created by Garry on 22/07/22.
//

import CoreData
import SwiftUI

final class MovieDefaultLocalDataSource: MovieLocalDataSource {
    private let container: NSPersistentContainer
    private let tvContainer: NSPersistentContainer
    
    init(
        container: NSPersistentContainer = PersistenceController.shared.container,
        tvContainer: NSPersistentContainer = TVPersistenceController.shared.container
    ) {
        self.container = container
        self.tvContainer = tvContainer
    }
    
    func saveToLocalMovieList(by movie: Movie) throws {
        let entity = MovieData(context: container.viewContext)
        
        entity.id = Int64(movie.id.orZero())
        entity.posterPath = movie.posterPath.orEmpty()
        entity.originalTitle = movie.originalTitle.orEmpty()
        entity.overview = movie.overview.orEmpty()
        
        if container.viewContext.hasChanges {
            try container.viewContext.save()
        }
    }
    
    func loadLocalMovie() async throws -> [MovieData] {
        return try await withCheckedThrowingContinuation({ continuation in
            do {
                let fetchRequest = try container.viewContext.fetch(MovieData.fetchRequest())
                
                continuation.resume(returning: fetchRequest)
            } catch {
                continuation.resume(throwing: error)
            }
        })
    }
    
    func deleteLocalItem() throws {
        Task.init {
            let item = try await loadLocalMovie()
            
            for item in item {
                container.viewContext.delete(item)
            }
        }
        
        if container.viewContext.hasChanges {
            try container.viewContext.save()
        }
    }
    
    func toggleFavorite(by movie: MovieData) throws {
        movie.favorite.toggle()
        
        if container.viewContext.hasChanges {
            try container.viewContext.save()
        }
    }
    
    func saveToLocalTVList(by tv: TVSeries) throws {
        let entity = TVData(context: tvContainer.viewContext)
        
        entity.id = Int64(tv.id.orZero())
        entity.posterPath = tv.posterPath.orEmpty()
        entity.name = tv.name.orEmpty()
        entity.overview = tv.overview.orEmpty()
        entity.backdropPath = tv.backdropPath.orEmpty()
        
        if tvContainer.viewContext.hasChanges {
            try tvContainer.viewContext.save()
        }
    }
    
    func loadLocalTV() async throws -> [TVData] {
        return try await withCheckedThrowingContinuation({ continuation in
            do {
                let fetchRequest = try tvContainer.viewContext.fetch(TVData.fetchRequest())
                
                continuation.resume(returning: fetchRequest)
            } catch {
                continuation.resume(throwing: error)
            }
        })
    }
    
    func deleteLocalTV() throws {
        Task.init {
            let item = try await loadLocalTV()
            
            for item in item {
                tvContainer.viewContext.delete(item)
            }
        }
        
        if tvContainer.viewContext.hasChanges {
            try tvContainer.viewContext.save()
        }
    }
    
    func toggleFavoriteTV(by tv: TVData) throws {
        tv.favorite.toggle()
        
        if tvContainer.viewContext.hasChanges {
            try tvContainer.viewContext.save()
        }
    }
}
