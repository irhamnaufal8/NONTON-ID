//
//  Users.swift
//  NONTON ID
//
//  Created by Garry on 17/07/22.
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: String?
    var email: String?
    var username: String?
}
