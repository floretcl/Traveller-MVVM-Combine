//
//  TemporaryLocationNav.swift
//  Traveller
//
//  Created by Clément FLORET on 24/03/2022.
//

import SwiftUI
import MapKit

struct TemporaryLocationNav: View {
    var gradient = Gradient(colors: [.accentColor, .clear])
    
    var body: some View {
        ZStack {
            HStack {
                MapView(
                    coordinateRegion: .constant(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                            span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))),
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: .constant(.none))
                .disabled(true)
                .shadow(color: .black, radius: 4, x: 0, y: 0)
                .overlay(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            }
            .cornerRadius(20)
            .shadow(color: Color("Transparent"), radius: 3, x: 3, y: 3)
            VStack {
                HStack {
                    Image(systemName: "location.circle.fill")
                    Text("Searching your location...")
                        .font(.headline)
                    Spacer()
                    if #available(iOS 15.0, *) {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                    } else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                }.padding()
                Spacer()
            }
            .foregroundColor(.white)
            .shadow(color: Color("Transparent"), radius: 3, x: 2, y: 2)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 90, maxHeight: 90, alignment: .center)
        .padding(.horizontal)
    }
}

struct TemporaryLocationNav_Previews: PreviewProvider {
    static var previews: some View {
        TemporaryLocationNav()
    }
}
