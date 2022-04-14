//
//  TranslationBasic.swift
//  Traveller
//
//  Created by Clément FLORET on 01/04/2022.
//

import Foundation
import Combine

class TranslationBasic: GoogleTranslation, ObservableObject {
    
    private let languageCode = Locale.current.languageCode
    private var key = "AIzaSyDwXAtUyiXZaFTUDnYZUPVrcRNv8QpQvqo"
    private let urlSession = URLSession.shared
    
    func getTranslation(text: String, source: String, target: String) -> AnyPublisher<TranslationBasicResponse, APIIssue> {
        return parseTranslation(urlComponents: getComponents(text: text, source: source, target: target))
    }
    
    func parseTranslation<TranslationBasicResponse: Decodable>(urlComponents: URLComponents) -> AnyPublisher<TranslationBasicResponse, APIIssue> {
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

    func decode<TranslationBasicResponse: Decodable>(_ data: Data) -> AnyPublisher<TranslationBasicResponse, APIIssue> {
        return Just(data)
            .decode(type: TranslationBasicResponse.self, decoder: JSONDecoder())
            .mapError { error in
                APIIssue.decoding(desc: "Json decoding error : \(error.localizedDescription)")
            }
            .eraseToAnyPublisher()
    }
    
    func getComponents(text: String, source: String, target: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "source", value: source),
            URLQueryItem(name: "target", value: target),
            URLQueryItem(name: "format", value: "text"),
        ]
        return urlComponents
    }
}
