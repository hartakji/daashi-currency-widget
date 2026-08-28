//
//  CurrencyWidgetPackDescriptor.swift
//  daashi-currency-widget
//
//  Created by Jean DAHER on 27/08/2026.
//

import WidgetFoundation
import SwiftUI

public struct CurrencyWidgetPackDescriptor: WidgetPackDescriptor {
    
    public let supportedComponentIdentifiers = [
        ExchangeRateConfig.componentIdentifier
    ]
    
    public static var packInfo: WidgetPackInfo {
        WidgetPackInfo(
            name: "Currency Widget",
            description: "Displays exchange rates from openexchangerates.org",
            image: Image("ic_widgetPack_oe", bundle: .module)
        )
    }
    
    public static var widgets: [WidgetFoundation.Widget] {
        [
            Widget(
                identifier: ExchangeRateConfig.componentIdentifier,
                name: "Exchange Rate",
                description: "Display exchange rate",
                image: Image("ic_widget_conversion", bundle: .module),
                availableFormFactor: [.square],
                availableSize: [.small]
            )
        ]
    }

    public static func configType(
        for identifier: String
    ) -> WidgetFoundation.WidgetConfigPayload.Type {
        switch identifier {
        case ExchangeRateConfig.componentIdentifier:
            return ExchangeRateConfig.self
        default:
            break
        }
        fatalError("Unable to find config for \(identifier)")
    }
    
    @MainActor
    public static func makeView<T>(
        for identifier: String,
        config: T
    ) -> (AnyView, any WidgetEventHandlerProtocol) where T : WidgetConfigPayload {
        switch identifier {
            
        case ExchangeRateConfig.componentIdentifier:
            if let config = config as? ExchangeRateConfig {
                
                let viewModel = ExchangeRateViewModel()
                let eventHandler = ExchangeRateEventHandler(
                    config: config,
                    viewModel: viewModel,
                    interactor: ExchangeRateInteractor(store: OpenExchangeRatesRemoteStore(token: config.token))
                )

                let view = ExchangeRateView(viewModel: viewModel, delegate: eventHandler)
                
                return (view: AnyView(view), eventHandler: eventHandler)
            }
        default:
            break
        }
        
        fatalError("Unable to make view for identifier: \(identifier)")
    }
    
    @MainActor
    public static func makeConfigurator(
        for identifier: String,
        config: (any WidgetConfigPayload)?,
        onSave: @escaping (any WidgetConfigPayload) -> Void
    ) -> AnyView {
        switch identifier {
            
        case ExchangeRateConfig.componentIdentifier:
            if let config = config as? ExchangeRateConfig? {
                let view = ExchangeRateConfiguratorView(
                    previousConfig: config,
                    onSave: { newConfig in
                        onSave(newConfig)
                    }
                )
                return AnyView(view)
            }
        default:
            break
        }
        
        fatalError("Unable to make configurator view for identifier: \(identifier)")
    }
}
