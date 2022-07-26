//
//  Movie.swift
//  NONTON ID
//
//  Created by Garry on 20/07/22.
//

import Foundation

struct TrendingMovie: Codable {
    let results: [Movie]?
}

struct Movie: Codable, Hashable {
    let id: Int?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case originalTitle = "original_title"
        case posterPath = "poster_path"
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id.orZero() == rhs.id.orZero()
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id.orZero())
    }
}

typealias SingleMovieResponse = Movie
