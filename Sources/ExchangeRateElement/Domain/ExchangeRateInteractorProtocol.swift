//
//  ExchangeRateInteractorProtocol.swift
//  CurrencyWidget
//
//  Created by Jean DAHER on 27/08/2026.
//

protocol ExchangeRateInteractorProtocol {
    func getExchangeRateList() async throws -> ExchangeRates
}
