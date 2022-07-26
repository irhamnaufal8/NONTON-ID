//
//  TVDetailViewModel.swift
//  NONTON ID
//
//  Created by Garry on 25/07/22.
//

import SwiftUI

final class TVDetailViewModel: ObservableObject {
    
    private let tvRepository: MovieRepository
    
    @Published var isError = false
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var tv: TVData
    @Published var tvList = [TVData]()
    @AppStorage("language") var language = NONTON_ID.LocalizationService.shared.language
    @Published var showSheet = false
    
    init(
        tvRepository: MovieRepository = MovieDefaultRepository(),
        tv: TVData
    ) {
        self.tvRepository = tvRepository
        self.tv = tv
    }
    
    @MainActor func onStartFetch() {
        self.isError = false
        self.isLoading = true
        self.errorMessage = ""
    }
    
    func imageUrl() -> String {
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let path = tv.posterPath
        return baseUrl+path.orEmpty()
    }
    
    func toggleFavorite() {
        do {
            try tvRepository.provideToggleFavoriteTV(by: tv)
            loadLocalTV()
            
        } catch {
            self.isLoading = false
            self.isError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    func loadLocalTV() {
        Task {
            do {
                let data = try await tvRepository.provideLoadLocalTV()
                
                DispatchQueue.main.async { [weak self] in
                    self?.tvList = data
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
