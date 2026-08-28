//
//  ExchangeRateConfiguratorView.swift
//  CurrencyWidget
//
//  Created by Jean DAHER on 27/08/2026.
//

import SwiftUI

struct ExchangeRateConfiguratorView: View {
    
    @State private var config: ExchangeRateConfig
    public var onSave: ((ExchangeRateConfig) -> Void)
    
    init(
        previousConfig: ExchangeRateConfig? = nil,
        onSave: (@escaping (ExchangeRateConfig) -> Void)
    ) {
        self.onSave = onSave
        self.config = previousConfig ?? ExchangeRateConfig(
            token: "",
            refreshInterval: 15,
            baseCurrency: .EUR,
            selectedCurrency: .USD,
            availableBaseCurrencies: ExchangeRateCurrency.allCases
        )
    }
    
    public var body: some View {
        VStack {
            Form {
                Section(header: Text("General")) {
                    TextField("Token", text: $config.token)
                }
                Section(header: Text("From Currency")) {
                    ForEach(config.availableBaseCurrencies) { aCurrency in
                        Button {
                            config.baseCurrency = aCurrency
                        } label: {
                            HStack {
                                Text(aCurrency.rawValue)
                                Spacer()
                                if config.baseCurrency == aCurrency {
                                    Image(systemName: "checkmark")
                                }
                            }
                            .contentShape(Rectangle())
                            .frame(maxWidth: .infinity)
                        }
                        .foregroundStyle(Color.primary)
                    }
                }
                Section(header: Text("To Currency")) {
                    ForEach(config.availableBaseCurrencies) { aCurrency in
                        Button(action: {
                            config.selectedCurrency = aCurrency
                        }, label: {
                            HStack {
                                Text(aCurrency.rawValue)
                                Spacer()
                                if config.selectedCurrency == aCurrency {
                                    Image(systemName: "checkmark")
                                } else {
                                    EmptyView()
                                }
                            }
                            .frame(maxWidth: .infinity)
                        })
                        .foregroundStyle(Color.primary)
                    }
                }
                Section(header: Text("Refresh frequency")) {
                    Slider(value: $config.refreshInterval, in: 15...180, step: 15)
                    HStack {
                        Spacer()
                        Text("Refresh every \(String(format: "%1.0f", config.refreshInterval)) min")
                    }
                }
            }
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    onSave(config)
                },
                       label: {
                    Text("Save")
                })
            })
        }
    }
}

#Preview {
    ExchangeRateConfiguratorView(onSave: { config in
        print("config: \(config)")
    })
}
