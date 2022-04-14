//
//  GoogleTranslationVM.swift
//  Traveller
//
//  Created by Clément FLORET on 01/04/2022.
//

import Foundation
import SwiftUI
import Combine

class GoogleTranslationVM: ObservableObject {
    @Published var basicTranslatedTexts: [String] = []
    @ObservedObject var translationBasic = TranslationBasic()
    
    private var subscription: Set<AnyCancellable> = []
    
    func requestTranslationBasic(text: String, source: String, target: String) {
        translationBasic.getTranslation(text: text, source: source, target: target)
            .map { response in
                TranslationBasicVM(translationBasic: response)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                switch response {
                case .failure: self?.basicTranslatedTexts = []
                case .finished: break
                }
            } receiveValue: { [weak self] translationBasicVM in
                guard let self = self else { return }
                self.basicTranslatedTexts = translationBasicVM.translations
            }
            .store(in: &subscription)

    }
}
