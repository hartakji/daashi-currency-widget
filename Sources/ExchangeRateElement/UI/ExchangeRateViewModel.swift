//
//  ExchangeRateViewModel.swift
//  BasicModulePackage
//
//  Created by Jean DAHER on 12/04/2025.
//

import Foundation

@MainActor
public class ExchangeRateViewModel: ObservableObject {
    
    @Published var baseCurrency: String
    @Published var exchangeRate: String
    @Published var targetCurrency: String
    @Published var lastUpdate: String
    
    init(
        baseCurrency: String = "N/A",
        exchangeRate: String = "N/A",
        targetCurrency: String = "N/A",
        lastUpdate: String = "Unknown"
    ) {
        self.baseCurrency = baseCurrency
        self.exchangeRate = exchangeRate
        self.targetCurrency = targetCurrency
        self.lastUpdate = lastUpdate
    }
}

