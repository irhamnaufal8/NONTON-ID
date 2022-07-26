//
//  String+orEmpty.swift
//  MyAnime
//
//  Created by Garry on 30/06/22.
//

import Foundation

extension Optional where Wrapped == String {
    func orEmpty() -> String {
        return self ?? ""
    }
}
