//
//  CurrentWeatherVM.swift
//  Traveller
//
//  Created by Clément FLORET on 21/03/2022.
//

import Foundation

class CurrentWeatherVM: ObservableObject {
    var id = UUID()
    private let currentForecast: CurrentWeatherResponse
    
    init(currentForecast: CurrentWeatherResponse) {
        self.currentForecast = currentForecast
    }
    
    var main: String {
        return currentForecast.weather.first?.main ?? "Unvailable"
    }
    
    var description: String {
        return currentForecast.weather.first?.description ?? "Unvailable"
    }
    
    var icon: String {
        return currentForecast.weather.first?.icon ?? ""
    }
    
    var temperatureCelsius: String {
        return currentForecast.main.temp.toTempCelsius
    }
    
    var temperatureFarenheit: String {
        return currentForecast.main.temp.toTempFarenheit
    }
    
    var temperatureFeelsLikeCelsius: String {
        return currentForecast.main.feels_like.toTempCelsius
    }
    
    var temperatureFeelsLikeFarenheit: String {
        return currentForecast.main.feels_like.toTempFarenheit
    }
    
    var temperatureMinCelsius: String {
        return currentForecast.main.temp_min.toTempCelsius
    }
    
    var temperatureMinFarenheit: String {
        return currentForecast.main.temp_min.toTempFarenheit
    }
    
    var temperatureMaxCelsius: String {
        return currentForecast.main.temp_max.toTempCelsius
    }
    
    var temperatureMaxFarenheit: String {
        return currentForecast.main.temp_max.toTempFarenheit
    }
    
    var visibility: String {
        return currentForecast.visibility.toVisibility
    }
    
    var pressure: String {
        return currentForecast.main.pressure.toPressHpa
    }
    
    var humidity: String {
        return currentForecast.main.humidity.toPercent
    }
    
    var windSpeedKM: String {
        return currentForecast.wind.speed.toKmPerHour
    }
    
    var windSpeedMiles: String {
        return currentForecast.wind.speed.toMilesPerHour
    }
    
    var windDir: String {
        return currentForecast.wind.deg.degreesToDirection
    }
    
    var clouds: String {
        return currentForecast.clouds.all.toPercent
    }
    
    var timestamp: TimeInterval {
        return TimeInterval(currentForecast.dt)
    }
    
    var country: String {
        return currentForecast.sys.country
    }
    
    var sunrise: TimeInterval {
        return TimeInterval(currentForecast.sys.sunrise)
    }
    
    var sunset: TimeInterval {
        return TimeInterval(currentForecast.sys.sunset)
    }
}
