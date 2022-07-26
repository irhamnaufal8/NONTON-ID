//
//  MoviePosterView.swift
//  NONTON ID
//
//  Created by Garry on 21/07/22.
//

import SwiftUI

struct MoviePosterView: View {
    @ObservedObject var viewModel: MoviePosterViewModel
    var body: some View {
        ImageLoader(
            url: viewModel.imageUrl(),
            width: (UIScreen.main.bounds.width / 3) - 20,
            height: ((UIScreen.main.bounds.width / 3) - 20) * 3 / 2
        )
        .cornerRadius(6)
    }
}
