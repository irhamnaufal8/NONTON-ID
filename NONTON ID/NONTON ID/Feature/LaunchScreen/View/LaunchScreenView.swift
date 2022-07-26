//
//  LaunchScreenView.swift
//  NONTON ID
//
//  Created by Garry on 26/07/22.
//

import SwiftUI

struct LaunchScreenView: View {
    @ObservedObject var viewModel = LaunchScreenViewModel()
    var body: some View {
        ZStack {
            ZStack {
                Color.primaryBackground
                
                Image.logoNontonID
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: viewModel.animate ? .fill : .fit)
                    .frame(width: viewModel.animate ? nil : 185)
                    .scaleEffect(viewModel.animate ? 3 : 1)
                    .frame(width: UIScreen.main.bounds.width)
            }
            .ignoresSafeArea()
            .onAppear {
                viewModel.animateSplash()
            }
            .opacity(viewModel.endSplash ? 0 : 1)
        .statusBar(hidden: true)
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .preferredColorScheme(.dark)
    }
}
