//
//  TranslationBasicVM.swift
//  Traveller
//
//  Created by Clément FLORET on 01/04/2022.
//

import Foundation

class TranslationBasicVM: ObservableObject {
    var id = UUID()
    private let translationBasic: TranslationBasicResponse
    
    init(translationBasic: TranslationBasicResponse) {
        self.translationBasic = translationBasic
    }
    
    var translations: [String] {
        return translationBasic.data.translations.map { translation in
            translation.translatedText
        }
    }
}
