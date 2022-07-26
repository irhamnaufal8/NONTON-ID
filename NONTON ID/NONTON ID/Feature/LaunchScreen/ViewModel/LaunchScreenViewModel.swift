//
//  LaunchScreenViewModel.swift
//  NONTON ID
//
//  Created by Garry on 26/07/22.
//

import SwiftUI

final class LaunchScreenViewModel: ObservableObject {
    @Published var animate = false
    @Published var endSplash = false
    
    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeOut(duration: 0.5)) {
                self.animate.toggle()
            }
            
            withAnimation(.linear(duration: 0.5)) {
                self.endSplash.toggle()
            }
        }
    }
}
