//
//  TextEditorManager.swift
//  Traveller
//
//  Created by Clément FLORET on 06/04/2022.
//

import Foundation

class TextEditorManager: ObservableObject {
    var characterLimit: Int
    
    init(charLimit: Int) {
        self.characterLimit = charLimit
    }
    
    @Published var textInput: String = "" {
        didSet {
            if textInput.count > 150 {
                textInput = String(textInput.prefix(characterLimit))
            }
        }
    }
}
