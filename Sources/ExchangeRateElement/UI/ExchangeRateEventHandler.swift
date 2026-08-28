//
//  ExchangeRateEventHandler.swift
//  CurrencyWidget
//
//  Created by Jean DAHER on 27/08/2026.
//

import Foundation
import WidgetFoundation

@MainActor
class ExchangeRateEventHandler {
    
    var viewModel: ExchangeRateViewModel
    var interactor: ExchangeRateInteractorProtocol
    var config: ExchangeRateConfig
        
    required init(
        config: ExchangeRateConfig,
        viewModel: ExchangeRateViewModel,
        interactor: ExchangeRateInteractorProtocol
    ) {
        self.config = config
        self.viewModel = viewModel
        self.interactor = interactor
    }

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    // MARK: -
    @MainActor
    func setViewModel(
        _ exchangeRates: ExchangeRates
    ) {
        viewModel.baseCurrency = "1 \(config.baseCurrency.rawValue) ="
        
        if config.baseCurrency.rawValue != exchangeRates.base {
            let reverseExchangeRate = exchangeRates.rates[config.baseCurrency.rawValue]
            viewModel.exchangeRate = reverseExchangeRate.map { (1 / $0).formatted(.number.precision(.fractionLength(0...3))) } ?? "N/A"
        } else {
            let exchangeRate = exchangeRates.rates[config.selectedCurrency.rawValue]
            viewModel.exchangeRate = exchangeRate.map { $0.formatted(.number.precision(.fractionLength(0...3))) } ?? "N/A"
        }
        
        viewModel.targetCurrency = config.selectedCurrency.rawValue
        viewModel.lastUpdate = dateFormatter.string(from: Date(timeIntervalSince1970: exchangeRates.timestamp))
    }
    
    @MainActor
    func performAsyncTask() async {
        Task { [weak self] in
            guard let self else { return }
            do {
                let exchangeRates = try await interactor.getExchangeRateList()
                setViewModel(exchangeRates)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func startFifteenMinuteLoop() {
        Task {
            await performAsyncTask()
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(60*Double(config.refreshInterval)))
                guard !Task.isCancelled else { break }
                await performAsyncTask()
            }
        }
    }
}

extension ExchangeRateEventHandler: ExchangeRateViewDelegate {
    
}

extension ExchangeRateEventHandler: WidgetEventHandlerProtocol {
    
    func onLoad() {
        startFifteenMinuteLoop()
    }
    
    @MainActor
    func onUnload() {
        
    }
}
