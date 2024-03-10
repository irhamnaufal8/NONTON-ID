//
//  HomeView.swift
//  NONTON ID
//
//  Created by Garry on 21/07/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient.background.ignoresSafeArea()
            
            VStack {
                Image.logoNontonID
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .padding(8)
                
                Divider()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        NavigationLink {
                            TrendingMovieListView()
                        } label: {
                            HStack {
                                Text(LocalizableText.trendingMovie.localized(viewModel.language))
                                    .font(.title2.weight(.bold))
                                    .foregroundColor(.primaryText)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.purple)
                                    .font(.headline)
                            }
                            .padding(.horizontal)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.trendingMovie, id:\.id) { item in
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
                            .padding(.horizontal)
                        }
                        .padding(.bottom)
                        
                        NavigationLink {
                            TrendingTVListView()
                        } label: {
                            HStack {
                                Text(LocalizableText.trendingTV.localized(viewModel.language))
                                    .font(.title2.weight(.bold))
                                    .foregroundColor(.primaryText)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.purple)
                                    .font(.headline)
                            }
                            .padding(.horizontal)
                        }

                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: viewModel.posterSize()))]) {
                            ForEach(viewModel.trendingTV, id:\.id) { item in
                                NavigationLink(destination: {
                                    TVDetailView(viewModel: TVDetailViewModel(tv: item))
                                }) {
                                    TVPosterView(viewModel: TVPosterViewModel(tv: item))
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
