//
//  HomeViewModel.swift
//  NONTON ID
//
//  Created by Garry on 17/07/22.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    private let movieRepository: MovieRepository
    
    @Published var isError = false
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var trendingMovie = [MovieData]()
    @Published var trendingTV = [TVData]()
    @Published var cobaTV = TVData()
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
            let isTvLocalEmpty = await isLocalTVEmpty()
            
            if isEmptyOnLocal {
                await getTrendingMovie()
            }
            if isTvLocalEmpty {
                await getTrendingTV()
            }
            
            //            await deleteItem()
            
            await loadLocalTrendingMovie()
            await loadLocalTrendingTV()
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
    
    func getTrendingTV() async {
        await onStartFetch()
        
        do {
            let response = try await movieRepository.provideGetTrendingTVSeries()
            
            for item in response.results ?? [] {
                try self.movieRepository.provideSaveToLocalTVList(by: item)
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
    
    func loadLocalTrendingTV() async {
        do {
            let data = try await movieRepository.provideLoadLocalTV()
            
            DispatchQueue.main.async { [weak self] in
                self?.trendingTV = data
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
    
    func isLocalTVEmpty() async -> Bool {
        do {
            let data = try await movieRepository.provideLoadLocalTV()
            return data.isEmpty
        } catch {
            return false
        }
    }
    
    func deleteItem() async {
        do {
            try movieRepository.provideDeleteLocalItem()
            try movieRepository.provideDeleteLocalTV()
        } catch {
            self.isLoading = false
            self.isError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    func posterSize() -> CGFloat {
        let width = (UIScreen.main.bounds.width / 2) - 20
        return width
    }
}
