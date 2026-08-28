//
//  ExchangeRateView.swift
//  BasicModulePackage
//
//  Created by Jean DAHER on 12/04/2025.
//

import SwiftUI

struct ExchangeRateView: View {

    @ObservedObject
    var viewModel: ExchangeRateViewModel
    var delegate: ExchangeRateViewDelegate?

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 3) {
                Text(viewModel.baseCurrency)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 12))
                    .bold()
                    .multilineTextAlignment(.center)
                Text(viewModel.exchangeRate)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 25))
                    .bold()
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                Text(viewModel.targetCurrency)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 12))
                    .bold()
                    .multilineTextAlignment(.center)
            }
            .frame(maxHeight: .infinity)
            VStack(spacing: 0) {
                Text(viewModel.lastUpdate)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 10))
                    .bold()
                    .multilineTextAlignment(.center)
            }.frame(maxHeight: 19)
        }
    }
}

import WidgetFoundation
#Preview {
    ExchangeRateView(
        viewModel: ExchangeRateViewModel(
            baseCurrency: "1 USD =",
            exchangeRate: "89550",
            targetCurrency: "LBP",
            lastUpdate: "10h55"
        )
    )
    .toWidget(
        size: .small,
        shape: .square,
        color: .black
    )
}
