//
//  EmptyYourListView.swift
//  NONTON ID
//
//  Created by Garry on 23/07/22.
//

import SwiftUI

struct EmptyYourListView: View {
    
    @ObservedObject var viewModel = YourListViewModel()
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack {
            Text(LocalizableText.emptyList.localized(viewModel.language))
                .font(.title2.weight(.bold))
                .foregroundColor(.primaryText)
                .padding()
            
            Image.loginIllustration
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 170)
                .padding()
            
            Button {
                tabSelection = 1
            } label: {
                Text(LocalizableText.exploreMovie.localized(viewModel.language))
                .foregroundColor(.white)
                .font(.headline)
                .padding(12)
                .frame(width: UIScreen.main.bounds.width - 32)
                .background(LinearGradient.gradient)
                .cornerRadius(6)
            }
        }
        .padding()
    }
}
