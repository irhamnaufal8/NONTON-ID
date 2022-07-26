//
//  Color+Default.swift
//  NONTON ID
//
//  Created by Garry on 16/07/22.
//

import Foundation
import SwiftUI

extension Color {
    
    // MARK: - Accent Color
    static let primaryBlue = Color("primary-blue")
    static let primaryGreen = Color("primary-green")
    
    // MARK: - Component Color
    static let primaryBackground = Color("primary-background")
    static let primaryText = Color("primary-text")
    static let loadingImage = Color("loading-image")
    static let secondaryBackground = Color("secondary-background")
}

extension LinearGradient {
    static let gradient = LinearGradient(colors: [Color.purple, Color.pink], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let gray = LinearGradient(colors: [Color.gray, Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let background = LinearGradient(colors: [Color.primaryBackground, Color.secondaryBackground], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let innerShadow = LinearGradient(colors: [Color.black.opacity(0), Color.black.opacity(0.8) ], startPoint: .top, endPoint: .bottom)
}
