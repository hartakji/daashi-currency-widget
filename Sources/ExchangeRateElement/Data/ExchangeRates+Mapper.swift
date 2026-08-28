//
//  ExchangeRates+Mapper.swift
//  BasicModulePackage
//
//  Created by Jean DAHER on 12/04/2025.
//

extension ExchangeRates {
    static func from(
        _ dto: ExchangeRatesDTO
    ) -> Self {
        .init(
            base: dto.base,
            timestamp: dto.timestamp,
            rates: dto.rates
        )
    }
}
