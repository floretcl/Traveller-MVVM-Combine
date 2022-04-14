//
//  SearchButton.swift
//  Traveller
//
//  Created by Clément FLORET on 22/03/2022.
//

import SwiftUI

struct SearchButton: View {
    @StateObject var userLocationVM: UserLocationVM
    @Binding var searchBarText: String
    
    var body: some View {
        Button(action: {
            userLocationVM.convertAdress(adress: searchBarText)
            hideKeyboard()
        }) {
            Text("Search")
                .foregroundColor(.white)
                .padding(8)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton(userLocationVM: UserLocationVM(), searchBarText: .constant("Locality"))
    }
}
