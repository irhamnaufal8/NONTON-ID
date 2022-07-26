//
//  SettingsLanguageViewModel.swift
//  NONTON ID
//
//  Created by Garry on 26/07/22.
//

import SwiftUI

final class SettingsLanguageViewModel: ObservableObject {
    
    @AppStorage("language") var language = NONTON_ID.LocalizationService.shared.language
    
    let languages: [Language] = [
        .indonesian,
        .english_us
    ]
    
    @Published var currentLanguage = NONTON_ID.LocalizationService.shared.language
    
    func changeLanguage(language: Language) {
        switch language {
        case .indonesian:
            LocalizationService.shared.language = .indonesian
            
            DispatchQueue.main.async { [weak self] in
                self?.currentLanguage = Language.indonesian
            }
            
        case .english_us:
            LocalizationService.shared.language = .english_us
            
            DispatchQueue.main.async { [weak self] in
                self?.currentLanguage = Language.english_us
            }
        }
    }
    
    func languageItem(language: Language) -> String {
        switch language {
        case .indonesian:
            return LocalizableText.bahasaIndonesia
        case .english_us:
            return LocalizableText.english
        }
    }
}
