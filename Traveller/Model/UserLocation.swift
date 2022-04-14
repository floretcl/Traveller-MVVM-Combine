//
//  UserLocation.swift
//  Traveller
//
//  Created by Clément FLORET on 15/03/2022.
//

import Foundation

struct UserLocation: Identifiable {
    var id = UUID()
    var lat: Double
    var long: Double
    var name: String
    var desc: String
    var locality: String
    var locality2: String
    var country: String
    var adminArea: String
    var adminArea2: String
    var postalCode: String
    var isoCountryCode: String
    var timeZone: TimeZone?
}
