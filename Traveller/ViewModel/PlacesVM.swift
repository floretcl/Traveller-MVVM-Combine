//
//  PlacesVM.swift
//  Traveller
//
//  Created by Clément FLORET on 17/03/2022.
//

import Foundation
import CoreData
import MapKit

class PlacesVM: ObservableObject {
    let persistenceController = PersistenceController.shared
    var viewContext: NSManagedObjectContext
    var predicateString: String?
    var placesCD: [Place] = []
    @Published var places: [PlaceVM] = []
    
    init() {
        self.viewContext = persistenceController.container.viewContext
        self.update()
    }
    
    func saveViewContext() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update() {
        self.fetchPlaces(ascending: true)
    }
    
    func fetchPlaces(ascending: Bool) {
        // create fetchRequest
        let fetchRequest = NSFetchRequest<Place>(entityName: "Place")
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Place.index, ascending: ascending)]
        do {
            // save results in placesCD array
            self.placesCD = try viewContext.fetch(fetchRequest)
            // convert and save results in places array
            self.places = self.placesCD.map { place in
                PlaceVM(place: place)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addPlace(placeVM: PlaceVM) {
        // create new Place for CoreData
        _ = placeVM.toPlace(viewContext: viewContext)
        saveViewContext()
        self.update()
    }
    
//    func movePlace(index: Int, destination: Int) {
//        var newIndex: Int = 0
//        // reorganize manual order
//        // If selected place moving down, reorganize upper others places
//        if index < destination {
//            newIndex = destination - 1
//            for n in 1...(newIndex - index) {
//                self.placesCD[(index + n)].index = Int16(index + (n - 1))
//            }
//            // If selected list moving up, reorganize lower others lists
//        } else if index > destination {
//            newIndex = destination
//            for n in 1...(index - newIndex) {
//                self.placesCD[(newIndex + (n - 1))].index = Int16(newIndex + n)
//            }
//        } else {
//            return
//        }
//        // move selected list and save
//        self.placesCD[index].index = Int16(newIndex)
//        self.saveViewContext()
//        self.update()
//    }
    
    func removePlace(index: Int) {
        // reorganize lists order of others lists before
        if placesCD[index].index < (placesCD.count - 1) {
            for n in (index + 1)...(placesCD.count - 1) {
                self.placesCD[n].index -= 1
            }
        }
        // then delete selected List of CoreData and save
        self.viewContext.delete(placesCD[index])
        self.saveViewContext()
        self.update()
    }
    
    func removeAllPlaces() {
        for place in placesCD {
            self.viewContext.delete(place)
        }
        self.saveViewContext()
        self.update()
    }
    
    func getRegion(lat: Double, long: Double) -> MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span = MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
        return MKCoordinateRegion(center: center, span: span)
    }
}
