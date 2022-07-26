//
//  TrendingMovieListView.swift
//  NONTON ID
//
//  Created by Garry on 24/07/22.
//

import SwiftUI

struct TrendingMovieListView: View {
    
    @ObservedObject var viewModel = TrendingMovieListViewModel()
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: viewModel.posterSize()))]) {
                if let data = viewModel.trendingMovie{
                    ForEach(data, id:\.id) { item in
                        NavigationLink(destination: {
                            MovieDetailView(
                                viewModel: MovieDetailViewModel(movie: item)
                            )
                        }) {
                            MoviePosterView(
                                viewModel: MoviePosterViewModel(movie: item)
                            )
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(LocalizableText.trendingMovie.localized(viewModel.language))
                        .foregroundColor(.primaryText)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .background(LinearGradient.background.ignoresSafeArea())
    }
}

struct TrendingMovieListView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingMovieListView()
    }
}
