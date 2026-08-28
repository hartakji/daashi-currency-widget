//
//  ExchangeRateRemoteStoreProtocol.swift
//  BasicModulePackage
//
//  Created by Jean DAHER on 12/04/2025.
//

protocol ExchangeRateRemoteStoreProtocol {
    func getExchangeRateList() async throws -> ExchangeRates
}
