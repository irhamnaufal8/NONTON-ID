//
//  TVCardView.swift
//  NONTON ID
//
//  Created by Garry on 24/07/22.
//

import SwiftUI

struct TVCardView: View {
    @ObservedObject var viewModel: TVCardViewModel
    var body: some View {
        HStack {
            ImageLoader(
                url: viewModel.imageUrl(),
                width: UIScreen.main.bounds.width / 5,
                height: UIScreen.main.bounds.width / 5
            )
            .clipped()
            .cornerRadius(10)
            .padding(.trailing)
            
            Text(viewModel.tv.name.orEmpty())
                .multilineTextAlignment(.leading)
                .foregroundColor(.primaryText)
                .font(.headline)
                .lineLimit(2)
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width)
    }
}
