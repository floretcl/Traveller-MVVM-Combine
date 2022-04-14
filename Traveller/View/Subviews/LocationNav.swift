//
//  LocationNav.swift
//  Traveller
//
//  Created by Clément FLORET on 24/03/2022.
//

import SwiftUI
import MapKit

struct LocationNav: View {
    var location: UserLocation
    @Binding var coordinateRegion: MKCoordinateRegion
    @Binding var userTrackingMode: MapUserTrackingMode
    @Binding var temperature: String
    
    var name: String {
        if location.locality != "" {
            return "\(location.locality)"
        } else if location.name != "" {
            return "\(location.name)"
        } else {
            return "..."
        }
    }
    var gradient = Gradient(colors: [.accentColor, .clear])
    
    var body: some View {
        ZStack {
            HStack {
                MapView(
                    coordinateRegion: $coordinateRegion,
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: $userTrackingMode)
                .disabled(true)
                .overlay(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            }
            .cornerRadius(20)
            .shadow(color: Color("Transparent"), radius: 3, x: 3, y: 3)
            VStack {
                HStack {
                    Image(systemName: "location.circle.fill")
                    Text(name)
                        .font(.headline)
                    Spacer()
                    Text(location.country)
                        .font(.subheadline)
                }.padding(.all)
                Spacer()
                HStack {
                    Spacer()
                    Text(temperature)
                }
                .padding(.leading)
                .padding(.bottom,25)
                .padding(.trailing)
            }
            .foregroundColor(.white)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 110, maxHeight: 110, alignment: .center)
        .padding(.horizontal)
    }
}

struct LocationNav_Previews: PreviewProvider {
    static var previews: some View {
        LocationNav(location: UserLocation(lat: 0, long: 0, name: "Name", desc: "description", locality: "Locality", locality2: "Locality 2", country: "Country", adminArea: "adminArea", adminArea2: "adminArea2", postalCode: "postalCode", isoCountryCode: "isoCountryCode"), coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))), userTrackingMode: .constant(.none), temperature: .constant("00°C"))
            
    }
}
