//
//  LatestRateVM.swift
//  Traveller
//
//  Created by Clément FLORET on 08/04/2022.
//

import Foundation

class LatestRateVM: ObservableObject {
    var id = UUID()
    private let latestRate: LatestRateResponse
    
    init(latestRate: LatestRateResponse) {
        self.latestRate = latestRate
    }
    
    var isValid: String {
        return latestRate.result
    }
    
    var date: String {
        return latestRate.time_last_update_unix.toDate24h
    }
    
    var sourceCurrencyCode: String {
        return latestRate.base_code
    }
    
    var targetCurrencyCode: String {
        return latestRate.target_code
    }
    
    var baseCurrencyRate: String {
        return String(latestRate.conversion_rate)
    }
    
    var conversionResult: String {
        return String(latestRate.conversion_result)
    }
}
