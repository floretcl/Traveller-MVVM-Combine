//
//  TextEditorWithBackground.swift
//  Traveller
//
//  Created by Clément FLORET on 04/04/2022.
//

import SwiftUI

struct TextEditorWithBackground: View {
    var text: Binding<String>
    var color: Color
    
    init(text: Binding<String>, color: Color) {
        UITextView.appearance().backgroundColor = .clear
        self.text = text
        self.color = color
    }
    
    var body: some View {
        TextEditor(text: text)
            .background(color)
    }
}

struct TextEditorWithBackground_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorWithBackground(text: .constant("Text"), color: Color("SdColor"))
    }
}
