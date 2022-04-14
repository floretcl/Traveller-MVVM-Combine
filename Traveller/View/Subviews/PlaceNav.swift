//
//  PlaceNav.swift
//  Traveller
//
//  Created by Clément FLORET on 29/03/2022.
//

import SwiftUI
import MapKit

struct PlaceNav: View {
    var place: PlaceVM
    @Binding var coordinateRegion: MKCoordinateRegion
    @Binding var userTrackingMode: MapUserTrackingMode
    
    var gradient = Gradient(colors: [.accentColor, .clear])
    
    var body: some View {
        ZStack {
            HStack {
                MapView(
                    coordinateRegion: $coordinateRegion,
                    interactionModes: .all,
                    showsUserLocation: false,
                    userTrackingMode: $userTrackingMode)
                .disabled(true)
                .overlay(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            }
            .cornerRadius(20)
            .shadow(color: Color("Transparent"), radius: 3, x: 3, y: 3)
            VStack {
                HStack {
                    Text(place.name)
                        .font(.headline)
                    Spacer()
                    Text(place.country)
                        .font(.subheadline)
                }.padding(.all)
                Spacer()
            }
            .foregroundColor(.white)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80, alignment: .center)
        .padding(.horizontal)
    }
}

struct PlaceNav_Previews: PreviewProvider {
    static var previews: some View {
        PlaceNav(place: PlaceVM(index: 0, lat: 0, long: 0, name: "Name", adminArea: "adminArea", country: "country", secondsFromGMT: 0, isoCountryCode: ""), coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))), userTrackingMode: .constant(.none))
            
    }
}
