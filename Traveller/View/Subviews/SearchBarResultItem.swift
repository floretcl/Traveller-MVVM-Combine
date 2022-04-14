//
//  SearchBarResultItem.swift
//  Traveller
//
//  Created by Clément FLORET on 22/03/2022.
//

import SwiftUI

struct SearchBarResultItem: View {
    @EnvironmentObject var placesVM: PlacesVM
    @Binding var resetTextfieldState: Bool
    
    var location: UserLocation
    var description: String {
        if location.locality != "" {
            return "\(location.locality) - \(location.country)"
        } else if location.name != "" {
            return "\(location.name) - \(location.country)"
        } else {
            return "Unknown"
        }
    }
    
    
    var body: some View {
        Button {
            resetTextfieldState = true
            self.addNewPlace(location: location)
        } label: {
            HStack {
                Text(description)
                    .foregroundColor(.accentColor)
                    .padding(.horizontal, 8)
                if description != "Unknown" {
                    Image(systemName: "plus.circle")
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.accentColor, lineWidth: 2))
            .padding(.horizontal, 12)
        }
    }
    
    func addNewPlace(location: UserLocation) {
        var locationName: String {
            if location.locality != "" {
                return location.locality
            } else {
                return location.name
            }
        }
        guard let timeZone = location.timeZone else {
            print("TimeZone nil")
            return
        }
        let newPlace = PlaceVM(
            index: placesVM.places.count,
            lat: location.lat,
            long: location.long,
            name: locationName,
            adminArea: location.adminArea,
            country: location.country,
            secondsFromGMT: timeZone.secondsFromGMT(),
            isoCountryCode: location.isoCountryCode)
        placesVM.addPlace(placeVM: newPlace)
    }
}

struct SearchBarResultItem_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarResultItem(resetTextfieldState: .constant(false), location: UserLocation(lat: 0, long: 0, name: "Name", desc: "description", locality: "Locality", locality2: "Locality 2", country: "Country", adminArea: "adminArea", adminArea2: "adminArea2", postalCode: "postalCode", isoCountryCode: "isoCountryCode"))
            .environmentObject(PlacesVM())
    }
}
