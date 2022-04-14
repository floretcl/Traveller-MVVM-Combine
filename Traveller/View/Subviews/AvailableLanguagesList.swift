//
//  AvailableLanguagesList.swift
//  Traveller
//
//  Created by Clément FLORET on 06/04/2022.
//

import SwiftUI

struct AvailableLanguagesList: View {
    var body: some View {
        ForEach(NamelangAvlbleGgleTransl.allCases.sorted(by: { lang, nextLang in
            lang.name < nextLang.name
        }), id: \.self) { language in
            Text(language.name).tag(language.name)
        }
    }
}
