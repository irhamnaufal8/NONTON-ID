//
//  TrendingTVListView.swift
//  NONTON ID
//
//  Created by Garry on 25/07/22.
//

import SwiftUI

struct TrendingTVListView: View {
    @ObservedObject var viewModel = TrendingTVListViewModel()
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: viewModel.posterSize()))]) {
                ForEach(viewModel.trendingTV, id:\.id) { item in
                    NavigationLink(destination: {
                        TVDetailView(viewModel: TVDetailViewModel(tv: item))
                    }) {
                        TVPosterView(
                            viewModel: TVPosterViewModel(tv: item)
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(LocalizableText.trendingTV.localized(viewModel.language))
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

struct TrendingTVListView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingTVListView()
    }
}
