//
//  TVSeries.swift
//  NONTON ID
//
//  Created by Garry on 24/07/22.
//

import Foundation

struct TVSeries: Identifiable, Codable, Hashable {
    let id: Int?
    let name: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, overview, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    static func == (lhs: TVSeries, rhs: TVSeries) -> Bool {
        return lhs.id.orZero() == rhs.id.orZero()
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id.orZero())
    }
}
