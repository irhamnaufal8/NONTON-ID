//
//  MovieCardViewModel.swift
//  NONTON ID
//
//  Created by Garry on 22/07/22.
//

import Foundation

final class MovieCardViewModel: ObservableObject {
    @Published var movie: MovieData
    
    init(movie: MovieData) {
        self.movie = movie
    }
    
    func imageUrl() -> String {
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let path = movie.posterPath.orEmpty()
        return baseUrl+path
    }
}
