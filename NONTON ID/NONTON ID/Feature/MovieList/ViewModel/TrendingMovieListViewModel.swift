//
//  TrendingMovieListViewModel.swift
//  NONTON ID
//
//  Created by Garry on 24/07/22.
//

import SwiftUI

final class TrendingMovieListViewModel: ObservableObject {
    
    private let movieRepository: MovieRepository
    
    @Published var isError = false
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var trendingMovie = [MovieData]()
    @AppStorage("language") var language = NONTON_ID.LocalizationService.shared.language
    @Published var tabSelection = 1
    
    init(
        movieRepository: MovieRepository = MovieDefaultRepository()
    ) {
        self.movieRepository = movieRepository
    }
    
    @MainActor func onStartFetch() {
        self.isError = false
        self.isLoading = true
        self.errorMessage = ""
    }
    
    func onAppear() {
        Task {
            let isEmptyOnLocal = await isLocalEmpty()
            
            if isEmptyOnLocal {
                await getTrendingMovie()
            }
            await loadLocalTrendingMovie()
        }
    }
    
    func getTrendingMovie() async {
        await onStartFetch()
        
        do {
            let response = try await movieRepository.provideGetTrendingMovie()
            
            for item in response.results ?? [] {
                try self.movieRepository.provideSaveToLocalMovieList(by: item)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
            }
            
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                self?.isError = true
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func loadLocalTrendingMovie() async {
        do {
            let data = try await movieRepository.provideLoadLocalMovie()
            
            DispatchQueue.main.async { [weak self] in
                self?.trendingMovie = data
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                self?.isError = true
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func isLocalEmpty() async -> Bool {
        do {
            let data = try await movieRepository.provideLoadLocalMovie()
            
            return data.isEmpty
            
        } catch {
            return false
        }
    }

    func posterSize() -> CGFloat {
        let width = (UIScreen.main.bounds.width / 3) - 20
        return width
    }
}
