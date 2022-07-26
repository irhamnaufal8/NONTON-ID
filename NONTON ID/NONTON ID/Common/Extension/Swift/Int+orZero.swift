//
//  Int+orZero.swift
//  MyAnime
//
//  Created by Garry on 28/06/22.
//

import Foundation
import SwiftUI

extension Optional where Wrapped == Int {
    func orZero() -> Int {
        return self ?? 0
    }
}

