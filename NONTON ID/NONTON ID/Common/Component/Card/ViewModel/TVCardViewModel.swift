//
//  TVCardViewModel.swift
//  NONTON ID
//
//  Created by Garry on 24/07/22.
//

import Foundation

final class TVCardViewModel: ObservableObject {
    @Published var tv: TVData
    
    init(tv: TVData) {
        self.tv = tv
    }
    
    func imageUrl() -> String {
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let path = tv.posterPath.orEmpty()
        return baseUrl+path
    }
}
