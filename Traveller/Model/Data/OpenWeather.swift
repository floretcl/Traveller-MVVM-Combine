//
//  OpenWeather.swift
//  Traveller
//
//  Created by Clément FLORET on 18/03/2022.
//

import Foundation
import Combine

protocol OpenWeather {
    func getWeather(location: UserLocation, units: Units) -> AnyPublisher<CurrentWeatherResponse, APIIssue>
    func parseWeather<CurrentWeatherResponse: Decodable>(urlComponents: URLComponents) -> AnyPublisher<CurrentWeatherResponse, APIIssue>
    func decode<CurrentWeatherResponse: Decodable>(_ data: Data) -> AnyPublisher<CurrentWeatherResponse, APIIssue>
    func getComponents(lat: Double, long: Double, units: Units) -> URLComponents
}

struct CurrentWeatherResponse: Decodable {
    var weather: [Weather]
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Int
    var name: String
    
    struct Weather: Decodable {
        var main: String
        var description: String
        var icon: String
    }

    struct Main: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Int
        var humidity: Int
    }

    struct Wind: Decodable {
        var speed: Double
        var deg: Int
    }

    struct Clouds: Decodable {
        var all: Int
    }

    struct Sys: Decodable {
        var country: String
        var sunrise: Int
        var sunset: Int
    }
}

enum Units: String, CaseIterable {
    case metric = "metric"
    case imperial = "imperial"
    
    var name: String { self.rawValue }
}
