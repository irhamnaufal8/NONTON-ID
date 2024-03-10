//
//  TrendingTVListViewModel.swift
//  NONTON ID
//
//  Created by Garry on 25/07/22.
//

import SwiftUI

final class TrendingTVListViewModel: ObservableObject {
    
    private let tvRepository: MovieRepository
    
    @Published var isError = false
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var trendingTV = [TVData]()
    @AppStorage("language") var language = NONTON_ID.LocalizationService.shared.language
    @Published var tabSelection = 1
    
    init(
        movieRepository: MovieRepository = MovieDefaultRepository()
    ) {
        self.tvRepository = movieRepository
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
                await getTrendingTV()
            }
            await loadLocalTrendingTV()
        }
    }
    
    func getTrendingTV() async {
        await onStartFetch()
        
        do {
            let response = try await tvRepository.provideGetTrendingTVSeries()
            
            for item in response.results ?? [] {
                try self.tvRepository.provideSaveToLocalTVList(by: item)
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
    
    func loadLocalTrendingTV() async {
        do {
            let data = try await tvRepository.provideLoadLocalTV()
            
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
            let data = try await tvRepository.provideLoadLocalTV()
            
            return data.isEmpty
            
        } catch {
            return false
        }
    }
    
    func posterSize() -> CGFloat {
        let width = (UIScreen.main.bounds.width / 2) - 20
        return width
    }
}

