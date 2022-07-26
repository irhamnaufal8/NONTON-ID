//
//  SettingsLanguageView.swift
//  NONTON ID
//
//  Created by Garry on 26/07/22.
//

import SwiftUI

struct SettingsLanguageView: View {
    @ObservedObject var viewModel = SettingsLanguageViewModel()
    var body: some View {
        ZStack {
            LinearGradient.background.ignoresSafeArea()
            
            List(viewModel.languages, id: \.self) { item in
                Button {
                    viewModel.changeLanguage(language: item)
                } label: {
                    HStack {
                        Text(viewModel.languageItem(language: item).localized(viewModel.language))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        if viewModel.currentLanguage == item {
                            Image(systemName: "checkmark")
                                .foregroundColor(.purple)
                                .font(.headline)
                        }
                    }
                }
                .listRowBackground(LinearGradient.background.opacity(0))
            }
            .listStyle(.plain)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(LocalizableText.language.localized(viewModel.language))
                        .foregroundColor(.primaryText)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Spacer()
                }
            }
        }
    }
}

struct SettingsLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLanguageView()
    }
}
