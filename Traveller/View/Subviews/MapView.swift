//
//  MapView.swift
//  Traveller
//
//  Created by Clément FLORET on 15/03/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var coordinateRegion: MKCoordinateRegion
    var interactionModes: MapInteractionModes
    var showsUserLocation: Bool
    @Binding var userTrackingMode: MapUserTrackingMode
    
    var body: some View {
        Map(
            coordinateRegion: $coordinateRegion,
            interactionModes: interactionModes,
            showsUserLocation: showsUserLocation,
            userTrackingMode: $userTrackingMode)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))),
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: .constant(.none))
    }
}
