//
//  PlaceVM.swift
//  Traveller
//
//  Created by Clément FLORET on 17/03/2022.
//

import Foundation
import CoreData

struct PlaceVM: Identifiable {
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
    var adminArea: String
    var country: String
    var secondsFromGMT: Int
    var isoCountryCode: String
    
    init(index: Int, lat: Double, long: Double, name: String, adminArea: String, country: String, secondsFromGMT: Int, isoCountryCode: String) {
        self.id = index
        self.name = name
        self.latitude = lat
        self.longitude = long
        self.adminArea = adminArea
        self.country = country
        self.secondsFromGMT = secondsFromGMT
        self.isoCountryCode = isoCountryCode
    }
    
    init(place: Place) {
        self.id = Int(place.index)
        self.latitude = place.lat
        self.longitude = place.long
        self.name = place.name ?? "Unknown"
        self.adminArea = place.adminArea ?? "Unknown"
        self.country = place.country ?? "Unknown"
        self.secondsFromGMT = Int(place.secondsFromGMT)
        self.isoCountryCode = place.isoCountryCode ?? ""
    }
    
    init(location: UserLocation) {
        self.id = -1
        
        var name: String {
            if location.locality != "" {
                return "\(location.locality)"
            } else if location.name != "" {
                return "\(location.name)"
            } else {
                return "..."
            }
        }
        self.name = name
        
        self.latitude = location.lat
        self.longitude = location.long
        self.adminArea = location.adminArea
        self.country = location.country
        self.secondsFromGMT = location.timeZone!.secondsFromGMT()
        self.isoCountryCode = location.isoCountryCode
    }
    
    func toPlace(viewContext: NSManagedObjectContext) -> Place {
        let place = Place(context: viewContext)
        place.index = Int16(id)
        place.name = name
        place.lat = latitude
        place.long = longitude
        place.adminArea = adminArea
        place.country = country
        place.secondsFromGMT = Int64(secondsFromGMT)
        place.isoCountryCode = isoCountryCode
        return place
    }
}
