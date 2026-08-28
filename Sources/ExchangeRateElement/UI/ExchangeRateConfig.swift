//
//  ExchangeRateConfig.swift
//  CurrencyWidget
//
//  Created by Jean DAHER on 27/08/2026.
//

import WidgetFoundation

public struct ExchangeRateConfig: WidgetConfigPayload {
    public static let componentIdentifier = "daashi.currency.exchange-rate"
    
    var token: String
    var refreshInterval: Float
    var baseCurrency: ExchangeRateCurrency
    var selectedCurrency: ExchangeRateCurrency
    var availableBaseCurrencies: [ExchangeRateCurrency]
}
