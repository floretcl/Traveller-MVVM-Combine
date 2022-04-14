//
//  CurrentWeather.swift
//  Traveller
//
//  Created by Clément FLORET on 18/03/2022.
//

import Foundation
import Combine

class CurrentWeather: OpenWeather, ObservableObject {
    
    private let languageCode = Locale.current.languageCode
    private var key = "2e2a2e047cc3b3f27af0c3a66270bad8"
    private let urlSession = URLSession.shared
    
    func getWeather(location: UserLocation, units: Units) -> AnyPublisher<CurrentWeatherResponse, APIIssue> {
        let latitude = location.lat
        let longitude = location.long
        return parseWeather(urlComponents: getComponents(lat: latitude, long: longitude, units: units))
    }
    
    func getWeather(lat: Double, long: Double, units: Units) -> AnyPublisher<CurrentWeatherResponse, APIIssue> {
        return parseWeather(urlComponents: getComponents(lat: lat, long: long, units: units))
    }
    
    func parseWeather<CurrentWeatherResponse: Decodable>(urlComponents: URLComponents) -> AnyPublisher<CurrentWeatherResponse, APIIssue> {
        guard let url = urlComponents.url else {
            let urlError = APIIssue.parsing(desc: "Json parsing url error")
            return Fail(error: urlError).eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: url)
            .mapError { error in
                APIIssue.parsing(desc: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { output in
                self.decode(output.data)
            }
            .eraseToAnyPublisher()
    }

    func decode<CurrentWeatherResponse: Decodable>(_ data: Data) -> AnyPublisher<CurrentWeatherResponse, APIIssue> {
        return Just(data)
            .decode(type: CurrentWeatherResponse.self, decoder: JSONDecoder())
            .mapError { error in
                APIIssue.decoding(desc: "Json decoding error : \(error.localizedDescription)")
            }
            .eraseToAnyPublisher()
    }
    
    func getComponents(lat: Double, long: Double, units: Units) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(long)),
            URLQueryItem(name: "appid", value: key),
            URLQueryItem(name: "units", value: units.name),
            URLQueryItem(name: "lang", value: languageCode)
        ]
        return urlComponents
    }
}
