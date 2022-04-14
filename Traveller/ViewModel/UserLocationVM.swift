//
//  UserLocationVM.swift
//  Traveller
//
//  Created by Clément FLORET on 15/03/2022.
//

import Foundation
import CoreLocation
import MapKit

class UserLocationVM: NSObject, ObservableObject {
    private var locationManager = CLLocationManager()
    private var geocoder = CLGeocoder()
    
    @Published var authorized: Bool
    @Published var userLocation: UserLocation?
    @Published var locationFound: UserLocation?
    
    override init() {
        self.authorized = false
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1000 // meters
        startLocationService()
    }
    
    func startLocationService() {
        switch locationManager.authorizationStatus {
        case .authorized, .authorizedAlways, .authorizedWhenInUse:
            self.authorized = true
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        case .notDetermined:
            self.authorized = false
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            self.authorized = false
            locationManager.requestWhenInUseAuthorization()
            break
        @unknown default:
            break
        }
    }
    
    func getRegion(location: UserLocation) -> MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        return MKCoordinateRegion(center: center, span: span)
    }
}


extension UserLocationVM: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorized, .authorizedAlways, .authorizedWhenInUse:
            self.authorized = true
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        case .notDetermined:
            self.authorized = false
            locationManager.stopUpdatingLocation()
            locationManager.stopUpdatingHeading()
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            self.authorized = false
            locationManager.stopUpdatingLocation()
            locationManager.stopUpdatingHeading()
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        convertLocation(location: location)
    }
    
    func convertLocation(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { places, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let place = places?.first, error == nil else { return }
            self.userLocation = self.convert(place: place)
        }
    }
    
    func convertAdress(adress: String) {
        self.resetLocationFound()
        geocoder.geocodeAddressString(adress, in: nil, preferredLocale: Locale.current) { places, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let place = places?.first, error == nil else { return }
            self.locationFound = self.convert(place: place)
        }
    }
    
    func convert(place: CLPlacemark) -> UserLocation {
        let coordinates = place.location?.coordinate
        let latitude = coordinates?.latitude ?? 0
        let longitude = coordinates?.longitude ?? 0
        let name = place.name ?? ""
        let desc = place.description 
        let locality = place.locality ?? ""
        let locality2 = place.subLocality ?? ""
        let country = place.country ?? ""
        let adminArea = place.administrativeArea ?? ""
        let adminArea2 = place.subAdministrativeArea ?? ""
        let postalCode = place.postalCode ?? ""
        let isoCountryCode = place.isoCountryCode ?? ""
        let timeZone = place.timeZone ?? nil
        return UserLocation(lat: latitude, long: longitude, name: name, desc: desc, locality: locality, locality2: locality2, country: country, adminArea: adminArea, adminArea2: adminArea2, postalCode: postalCode, isoCountryCode: isoCountryCode, timeZone: timeZone)
    }
    
    func resetLocationFound() {
        self.locationFound = nil
    }
}
