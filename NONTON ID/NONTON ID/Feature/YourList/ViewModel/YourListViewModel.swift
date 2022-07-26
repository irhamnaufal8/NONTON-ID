//
//  YourListViewModel.swift
//  NONTON ID
//
//  Created by Garry on 23/07/22.
//

import Foundation
import SwiftUI

final class YourListViewModel: ObservableObject {
    
    private let movieRepository: MovieRepository
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var isError = false
    @Published var movieData = [MovieData]()
    @Published var tvData = [TVData]()
    @AppStorage("language") var language = NONTON_ID.LocalizationService.shared.language
    @Published var listEmpty = true
    
    init(movieRepository: MovieRepository = MovieDefaultRepository()) {
        self.movieRepository  = movieRepository
    }
    
    @MainActor func firstFetch() {
        self.isError = false
        self.errorMessage = ""
        self.isLoading = true
    }
    
    enum Filter: String {
        case all = "all"
        case movie = "movie"
        case tv = "tv"
    }
    
    let filter: [Filter] = [.all, .movie, .tv]
    
    @Published var currentFilter = Filter.all
    
    func loadFilteredList(filter: Filter) {
        Task {
            switch filter {
            case .all:
                await loadFavoriteLocalMovie()
                await loadFavoriteLocalTV()
                
                DispatchQueue.main.async { [weak self] in
                    withAnimation {
                        self?.currentFilter = .all
                    }
                }
                
            case .movie:
                await loadFavoriteLocalMovie()
                
                DispatchQueue.main.async { [weak self] in
                    withAnimation {
                        self?.currentFilter = .movie
                    }
                }
                
            case .tv:
                await loadFavoriteLocalTV()
                
                DispatchQueue.main.async { [weak self] in
                    withAnimation {
                        self?.currentFilter = .tv
                    }
                }
            }
        }
    }
    
    func loadFavoriteLocalMovie() async {
        do {
            let data = try await movieRepository.provideLoadLocalMovie().filter({ movie in
                movie.favorite == true
            })
            
            DispatchQueue.main.async { [weak self] in
                self?.movieData = data
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                self?.isError = true
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func loadFavoriteLocalTV() async {
        do {
            let data = try await movieRepository.provideLoadLocalTV().filter({ tv in
                tv.favorite == true
            })
            
            DispatchQueue.main.async { [weak self] in
                self?.tvData = data
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                self?.isError = true
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func isListEmpty() async -> Bool {
        do {
            let data = try await movieRepository.provideLoadLocalMovie().filter({ movie in
                movie.favorite == true
            })
            
            return data.isEmpty
            
        } catch {
            return false
        }
    }
    
    func isTVListEmpty() async -> Bool {
        do {
            let data = try await movieRepository.provideLoadLocalTV().filter({ tv in
                tv.favorite == true
            })
            
            return data.isEmpty
            
        } catch {
            return false
        }
    }
    
    func onMovieListAppear() {
        Task {
            let listIsEmpty = await isListEmpty()
            let TVListIsEmpty = await isTVListEmpty()
            if listIsEmpty && TVListIsEmpty {
                DispatchQueue.main.async { [weak self] in
                    self?.listEmpty = true
                }
            } else {
                loadFilteredList(filter: self.currentFilter)
                DispatchQueue.main.async { [weak self] in
                    self?.listEmpty = false
                }
            }
        }
    }
}
