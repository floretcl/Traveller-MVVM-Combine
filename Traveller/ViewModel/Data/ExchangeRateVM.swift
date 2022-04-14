//
//  ExchangeRateVM.swift
//  Traveller
//
//  Created by Clément FLORET on 08/04/2022.
//

import Foundation
import SwiftUI
import Combine

class ExchangeRateVM: ObservableObject {
    @Published var latestCurrencyRate: LatestRateVM? = nil
    @ObservedObject var latestRate = LatestRate()
    
    private var subscription: Set<AnyCancellable> = []
    
    func requestLatestCurrencyRate(sourceCurrency: String, targetCurrency: String, value: Double) {
        latestRate.getCurrencyRate(sourceCurrency: sourceCurrency, targetCurrency: targetCurrency, value: value)
            .map { response in
                LatestRateVM(latestRate: response)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                switch response {
                case .failure: self?.latestCurrencyRate = nil
                case .finished: break
                }
            } receiveValue: { [weak self] currencyRate in
                guard let self = self else { return }
                self.latestCurrencyRate = currencyRate
            }
            .store(in: &subscription)

    }
}
