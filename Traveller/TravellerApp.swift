//
//  TravellerApp.swift
//  Traveller
//
//  Created by Clément FLORET on 15/03/2022.
//

import SwiftUI
import CoreData

@main
struct TravellerApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var places = PlacesVM()
    @StateObject var userLocation = UserLocationVM()
    @AppStorage("units") var units: Units = .metric

    var body: some Scene {
        WindowGroup {
            ContentView(units: _units)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(places)
                .environmentObject(userLocation)
        }
    }
}
