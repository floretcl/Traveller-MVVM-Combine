//
//  WeatherVM.swift
//  Traveller
//
//  Created by Clément FLORET on 21/03/2022.
//

import Foundation
import SwiftUI
import Combine

class OpenWeatherVM: ObservableObject {
    @Published var currentForecast: CurrentWeatherVM? = nil
    @Published var placeCurrentForecast: CurrentWeatherVM? = nil
    @ObservedObject var currentWeather = CurrentWeather()
    
    private var subscription: Set<AnyCancellable> = []
    private var subscriptionPlace: Set<AnyCancellable> = []
    
    func requestCurrentForecast(userLocation: UserLocation, units: Units) {
        currentWeather.getWeather(location: userLocation, units: units)
            .map { response in
                CurrentWeatherVM(currentForecast: response)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                switch response {
                case .failure: self?.currentForecast = nil
                case .finished: break
                }
            } receiveValue: { [weak self] currentWeatherVM in
                guard let self = self else { return }
                self.currentForecast = currentWeatherVM
            }
            .store(in: &subscription)

    }
    
    func requestCurrentForecast(lat: Double, long: Double, units: Units) {
        currentWeather.getWeather(lat: lat, long: long, units: units)
            .map { response in
                CurrentWeatherVM(currentForecast: response)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                switch response {
                case .failure: self?.placeCurrentForecast = nil
                case .finished: break
                }
            } receiveValue: { [weak self] currentWeatherVM in
                guard let self = self else { return }
                self.placeCurrentForecast = currentWeatherVM
            }
            .store(in: &subscriptionPlace)
    }
}
