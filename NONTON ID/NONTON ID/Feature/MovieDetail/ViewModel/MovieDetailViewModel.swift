//
//  MovieDetailViewModel.swift
//  NONTON ID
//
//  Created by Garry on 22/07/22.
//

import Foundation
import SwiftUI

final class MovieDetailViewModel: ObservableObject {
    
    private let movieRepository: MovieRepository
    
    @Published var isError = false
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var movie: MovieData
    @Published var movieList = [MovieData]()
    @AppStorage("language") var language = NONTON_ID.LocalizationService.shared.language
    @Published var showSheet = false
    
    init(
        movieRepository: MovieRepository = MovieDefaultRepository(),
        movie: MovieData
    ) {
        self.movieRepository = movieRepository
        self.movie = movie
    }
    
    @MainActor func onStartFetch() {
        self.isError = false
        self.isLoading = true
        self.errorMessage = ""
    }
    
    func imageUrl() -> String {
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let path = movie.posterPath
        return baseUrl+path.orEmpty()
    }
    
    func toggleFavorite() {
        do {
            try movieRepository.provideToggleFavorite(by: movie)
            loadLocalMovie()
            
        } catch {
            self.isLoading = false
            self.isError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    func loadLocalMovie() {
        Task {
            do {
                let data = try await movieRepository.provideLoadLocalMovie()
                
                DispatchQueue.main.async { [weak self] in
                    self?.movieList = data
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                    self?.isError = true
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func showingSheet() {
        self.showSheet.toggle()
    }
}
