//
//  MoviePosterViewModel.swift
//  NONTON ID
//
//  Created by Garry on 21/07/22.
//

import Foundation
import SwiftUI

final class MoviePosterViewModel: ObservableObject {
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
