//
//  SearchBarResult.swift
//  Traveller
//
//  Created by Clément FLORET on 22/03/2022.
//

import SwiftUI

struct SearchBarResult: View {
    @StateObject var userLocationVM: UserLocationVM
    @Binding var searchBarText: String
    @Binding var resetTextfieldState: Bool
    
    var body: some View {
        if searchBarText.isBlank == false && userLocationVM.locationFound != nil {
            Section {
                SearchBarResultItem(
                    resetTextfieldState: $resetTextfieldState,
                    location: userLocationVM.locationFound!)
            }
        }
    }
}

struct SearchBarResult_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarResult(userLocationVM: UserLocationVM(), searchBarText: .constant("Search"), resetTextfieldState: .constant(false))
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .environmentObject(PlacesVM())
    }
}
