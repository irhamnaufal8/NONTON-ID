//
//  YourListView.swift
//  NONTON ID
//
//  Created by Garry on 23/07/22.
//

import SwiftUI

struct YourListView: View {
    
    @ObservedObject var viewModel = YourListViewModel()
    @Binding var tabSelection: Int
    
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
                
                if viewModel.listEmpty {
                    Spacer()
                    EmptyYourListView(tabSelection: $tabSelection)
                    Spacer()
                } else {
                    
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(LinearGradient.gradient)
                            .clipShape(Circle())
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.filter, id:\.self) { item in
                                    Button {
                                        withAnimation(.spring()) {
                                            viewModel.loadFilteredList(filter: item)
                                        }
                                    } label: {
                                        Text(item.rawValue.localized(viewModel.language))
                                            .foregroundColor(viewModel.currentFilter == item ? Color.purple : Color.primaryText)
                                            .font(viewModel.currentFilter == item ? .headline : .body)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 32)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(LocalizableText.yourList.localized(viewModel.language))
                                    .font(.title2.weight(.bold))
                                    .foregroundColor(.primaryText)
                                    .padding(.horizontal)
                                
                                Spacer()
                            }
                            
                            switch viewModel.currentFilter {
                            case .all:
                                if let data = viewModel.movieData {
                                    ForEach(data, id:\.id) { item in
                                        NavigationLink(destination: {
                                            MovieDetailView(
                                                viewModel: MovieDetailViewModel(movie: item)
                                            )
                                        }) {
                                            MovieCardView(viewModel: MovieCardViewModel(movie: item))
                                        }
                                    }
                                }
                                
                                if let data = viewModel.tvData {
                                    ForEach(data, id:\.id) { item in
                                        NavigationLink(destination: {
                                            TVDetailView(
                                                viewModel: TVDetailViewModel(tv: item)
                                            )
                                        }) {
                                            TVCardView(viewModel: TVCardViewModel(tv: item))
                                        }
                                    }
                                }
                                
                            case.movie:
                                if let data = viewModel.movieData {
                                    ForEach(data, id:\.id) { item in
                                        NavigationLink(destination: {
                                            MovieDetailView(
                                                viewModel: MovieDetailViewModel(movie: item)
                                            )
                                        }) {
                                            MovieCardView(viewModel: MovieCardViewModel(movie: item))
                                        }
                                    }
                                }
                                
                            case.tv:
                                if let data = viewModel.tvData {
                                    ForEach(data, id:\.id) { item in
                                        NavigationLink(destination: {
                                            TVDetailView(
                                                viewModel: TVDetailViewModel(tv: item)
                                            )
                                        }) {
                                            TVCardView(viewModel: TVCardViewModel(tv: item))
                                        }
                                    }
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
            withAnimation {
                viewModel.onMovieListAppear()
            }
        }
    }
}
