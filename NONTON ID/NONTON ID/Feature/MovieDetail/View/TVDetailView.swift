//
//  TVDetailView.swift
//  NONTON ID
//
//  Created by Garry on 25/07/22.
//

import SwiftUI

struct TVDetailView: View {
    @ObservedObject var viewModel: TVDetailViewModel
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Button {
                    viewModel.showingSheet()
                } label: {
                    ImageLoader(
                        url: viewModel.imageUrl(),
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.width
                    )
                    .clipped()
                }
                .fullScreenCover(isPresented: $viewModel.showSheet) {
                    FullImage(url: viewModel.imageUrl())
                }

                
                VStack(alignment: .leading) {
                    Text(viewModel.tv.name.orEmpty())
                        .font(.title2.weight(.bold))
                        .foregroundColor(.primaryText)
                        .padding(.bottom)
                    
                    Text(viewModel.tv.overview.orEmpty())
                        .font(.body)
                        .foregroundColor(.primaryText)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(viewModel.tv.name.orEmpty())
                        .foregroundColor(.primaryText)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Button {
                        viewModel.toggleFavorite()
                    } label: {
                        Image(systemName: viewModel.tv.favorite ? "bookmark.fill" : "bookmark")
                            .foregroundColor(Color.purple)
                    }
                    
                }
            }
        }
        .background(LinearGradient.background.ignoresSafeArea())
    }
}
