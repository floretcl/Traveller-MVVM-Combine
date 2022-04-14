//
//  OpenWeatherImageVM.swift
//  Traveller
//
//  Created by Clément FLORET on 25/03/2022.
//

import Foundation
import SwiftUI
import Combine

class OpenWeatherImageVM: ObservableObject {
    @Published var uiImage: UIImage?
    private var subscription: AnyCancellable?
    private let urlSession = URLSession.shared
    
    deinit {
        subscription?.cancel()
    }
    
    func load(iconUrl: String) {
        let urlString = "https://openweathermap.org/img/wn/\(iconUrl).png"
        guard let url = URL(string: urlString) else { return }
        self.subscription = urlSession.dataTaskPublisher(for: url)
            .map { response in
                UIImage(data: response.data)
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] uiimage in
                self?.uiImage = uiimage
            }
    }
}
