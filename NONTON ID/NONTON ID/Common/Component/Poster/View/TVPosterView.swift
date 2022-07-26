//
//  TVPosterView.swift
//  NONTON ID
//
//  Created by Garry on 24/07/22.
//

import SwiftUI

struct TVPosterView: View {
    @ObservedObject var viewModel: TVPosterViewModel
    var posterWidth = CGFloat(UIScreen.main.bounds.width / 2) - 20
    var posterHeight = CGFloat(((UIScreen.main.bounds.width / 2) - 20) * 281 / 500)
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoader(
                url: viewModel.imageUrl(),
                width: posterWidth,
                height: posterHeight
            )
            
            LinearGradient.innerShadow
                .frame(
                    width: posterWidth,
                    height: posterHeight
                )
            
            Text(viewModel.tv.name.orEmpty())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
        .cornerRadius(6)
    }
}
