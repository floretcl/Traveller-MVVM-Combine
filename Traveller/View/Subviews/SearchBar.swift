//
//  SearchBar.swift
//  Traveller
//
//  Created by Clément FLORET on 22/03/2022.
//

import SwiftUI

struct SearchBar: View {
    @StateObject var userLocationVM: UserLocationVM
    @Binding var searchBarText: String
    @Binding var isEditing: Bool
    @Binding var resetTextfieldState: Bool

    var body: some View {
        HStack {
            if #available(iOS 15.0, *) {
                TextField("Search", text: $searchBarText) { isEditing in
                    if isEditing {
                        userLocationVM.convertAdress(adress: searchBarText)
                    }
                }
                .foregroundColor(Color.accentColor)
                .padding(8)
                .padding(.horizontal, 25)
                .background(Color("SdColor"))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.accentColor)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            SearchBarCloseButton(resetTextfieldState: $resetTextfieldState)
                        }
                    }
                )
                .padding(.horizontal, 12)
                .disableAutocorrection(true)
                .onTapGesture {
                    self.isEditing = true
                }
                .onSubmit {
                    userLocationVM.convertAdress(adress: searchBarText)
                }
            } else {
                // Under iOS15
                TextField("Search", text: $searchBarText, onCommit: {
                    userLocationVM.convertAdress(adress: searchBarText)
                })
                .foregroundColor(Color.accentColor)
                .padding(8)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.accentColor)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            SearchBarCloseButton(resetTextfieldState: $resetTextfieldState)
                        }
                    }
                )
                .padding(.horizontal, 12)
                .disableAutocorrection(true)
                .onTapGesture {
                    self.isEditing = true
                }
            }
            if isEditing {
                SearchButton(userLocationVM: userLocationVM, searchBarText: $searchBarText)
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(userLocationVM: UserLocationVM(), searchBarText: .constant("Locality"), isEditing: .constant(true), resetTextfieldState: .constant(false))
    }
}
