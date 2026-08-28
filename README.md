# CurrencyWidget

A Swift Package that provides a **Currency Widget** for the Daashi widget app. It displays live exchange rates fetched from [openexchangerates.org](https://openexchangerates.org).

This package implements a `WidgetPackDescriptor` from [`daashi-widget-foundation`](https://github.com/hartakji/daashi-widget-foundation), the package that defines the abstract widget contract (descriptors, configuration payloads, view/event handler protocols) used across all Daashi widgets. `CurrencyWidget` plugs into that contract to provide a concrete widget implementation.

## Features

- **Exchange Rate widget**: shows the conversion rate between a base currency and a selected currency.
- Supports all currencies exposed by the Open Exchange Rates API (see `ExchangeRateCurrency`).
- Configurable refresh interval and API token.
- Small, square form factor.

## Requirements

- iOS 16.0+
- Swift 5.7+
- An [Open Exchange Rates](https://openexchangerates.org) API token

## Installation

Add the package as a Swift Package dependency alongside `daashi-widget-foundation`:

```swift
dependencies: [
    .package(url: "https://github.com/hartakji/daashi-currency-widget", from: "1.0.0"),
    .package(url: "https://github.com/hartakji/daashi-widget-foundation", from: "1.0.0")
]
```

> Pin exact versions or ranges (`from:`, `.upToNextMajor(from:)`, `exact:`, etc.) rather than tracking a branch, so version mismatches between `CurrencyWidget` and `WidgetFoundation` surface as resolvable dependency errors instead of being silently masked.

## Architecture

The package is organized as follows:

```
Sources/
├── CurrencyWidgetPackDescriptor.swift   # Entry point conforming to WidgetPackDescriptor
└── ExchangeRateElement/
    ├── Domain/    # Business logic: models, interactor, protocols
    ├── Data/      # Remote data source (OpenExchangeRatesRemoteStore) and DTO mapping
    └── UI/        # SwiftUI views, view model, configurator, and event handling
```

- **`CurrencyWidgetPackDescriptor`**: describes the widget pack (name, icon, description) and the widgets it exposes, and builds the corresponding views and configurators for the host app.
- **`ExchangeRateConfig`**: the widget's configuration payload (token, refresh interval, base/selected currency, available currencies).
- **`OpenExchangeRatesRemoteStore`**: fetches live exchange rates from the Open Exchange Rates API.
- **`ExchangeRateInteractor`**: domain logic that turns raw rates into the data the widget displays.
- **`ExchangeRateView`** / **`ExchangeRateConfiguratorView`**: the widget's display and configuration UI, driven by `ExchangeRateViewModel` and `ExchangeRateEventHandler`.

## Usage

The host app discovers this widget pack via `CurrencyWidgetPackDescriptor.packInfo` and `CurrencyWidgetPackDescriptor.widgets`, then uses `CurrencyWidgetPackDescriptor.makeView(for:config:)` and `makeConfigurator(for:config:onSave:)` to render the widget and its settings screen, following the contract defined by `WidgetFoundation`.

## License

This project has no license file yet. All rights reserved unless stated otherwise.
