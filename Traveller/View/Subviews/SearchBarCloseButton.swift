//
//  SearchBarCloseButton.swift
//  Traveller
//
//  Created by Clément FLORET on 23/03/2022.
//

import SwiftUI

struct SearchBarCloseButton: View {
    @Binding var resetTextfieldState: Bool
    
    var body: some View {
        Button(action: {
            resetTextfieldState = true
        }) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.accentColor)
                .padding(.trailing, 10)
        }
    }
}

struct SearchBarCloseButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarCloseButton(resetTextfieldState: .constant(false))
    }
}
