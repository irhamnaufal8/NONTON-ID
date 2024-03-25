//
//  DefaultResponse.swift
//  NONTON ID
//
//  Created by Irham Naufal on 11/03/24.
//

import Foundation

struct ArrayResult<Result: Codable>: Codable {
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
    var results: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
