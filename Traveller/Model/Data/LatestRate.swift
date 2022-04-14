//
//  LatestRate.swift
//  Traveller
//
//  Created by Clément FLORET on 07/04/2022.
//

import Foundation
import Combine

class LatestRate: ExchangeRate, ObservableObject {
    
    private var key = ""
    private let urlSession = URLSession.shared
    
    func getCurrencyRate(sourceCurrency: String, targetCurrency: String, value: Double) -> AnyPublisher<LatestRateResponse, APIIssue> {
        return parseCurrencyRate(urlComponents: getComponents(sourceCurrency: sourceCurrency, targetCurrency: targetCurrency, value: value))
    }
    
    func parseCurrencyRate<LatestRateResponse: Decodable>(urlComponents: URLComponents) -> AnyPublisher<LatestRateResponse, APIIssue> {
        guard let url = urlComponents.url else {
            let urlError = APIIssue.parsing(desc: "Json parsing url error")
            return Fail(error: urlError).eraseToAnyPublisher()
        }
        print(url) // TODO: to delete
        return urlSession.dataTaskPublisher(for: url)
            .mapError { error in
                APIIssue.parsing(desc: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { output in
                self.decode(output.data)
            }
            .eraseToAnyPublisher()
    }
    
    func decode<LatestRateResponse: Decodable>(_ data: Data) -> AnyPublisher<LatestRateResponse, APIIssue> {
        return Just(data)
            .decode(type: LatestRateResponse.self, decoder: JSONDecoder())
            .mapError { error in
                APIIssue.decoding(desc: "Json decoding error : \(error.localizedDescription)")
            }
            .eraseToAnyPublisher()
    }
    
    func getComponents(sourceCurrency: String, targetCurrency: String, value: Double) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "v6.exchangerate-api.com"
        urlComponents.path = "/v6/\(key)/pair/\(sourceCurrency)/\(targetCurrency)/\(value)"
        return urlComponents
    }
}
