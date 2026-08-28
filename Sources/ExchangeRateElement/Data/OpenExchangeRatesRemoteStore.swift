//
//  ExchangeRateRemoteStore.swift
//  BasicModulePackage
//
//  Created by Jean DAHER on 12/04/2025.
//
import Foundation

class OpenExchangeRatesRemoteStore {

    public enum Error: Swift.Error {
        case invalidUrl
        case invalidResponse
        case unableToGenerateToken
    }
    
    var token: String
    var baseUrl = "https://openexchangerates.org/api/latest.json?"

    public init(token: String) {
        self.token = token
    }

}

extension OpenExchangeRatesRemoteStore: ExchangeRateRemoteStoreProtocol {
    
    func getExchangeRateList() async throws -> ExchangeRates {
        
        let urlString = baseUrl + "app_id=\(token)"
        guard let url = URL(string: urlString) else {
            throw Error.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        return ExchangeRates.from(try decoder.decode(ExchangeRatesDTO.self, from: data))
    }
}
