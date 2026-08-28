//
//  ExchangeRatesDTO.swift
//  BasicModulePackage
//
//  Created by Jean DAHER on 12/04/2025.
//

public struct ExchangeRatesDTO: Decodable {
    let base: String
    let timestamp: Double
    let rates: [String: Double]
}
