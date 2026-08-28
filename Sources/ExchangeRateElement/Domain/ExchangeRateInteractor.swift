//
//  ExchangeRateInteractor.swift
//  CurrencyWidget
//
//  Created by Jean DAHER on 27/08/2026.
//

class ExchangeRateInteractor {
    
    private let store: ExchangeRateRemoteStoreProtocol
    
    init(store: ExchangeRateRemoteStoreProtocol) {
        self.store = store
    }
}

extension ExchangeRateInteractor: ExchangeRateInteractorProtocol {
    
    func getExchangeRateList() async throws -> ExchangeRates {
        try await store.getExchangeRateList()
    }
}
