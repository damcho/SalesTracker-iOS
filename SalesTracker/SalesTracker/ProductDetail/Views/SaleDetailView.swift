//
//  SaleDetailView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import SwiftUI

struct SaleDetailView: View, Identifiable {
    var id: UUID { UUID() }

    let viewModel: SaleDetailViewModel

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.localCurrencySaleAmount).font(.system(.headline))
                Spacer()
                Text(viewModel.convertedCurrencySaleAmount).font(.system(.headline))
            }
            HStack {
                Text(viewModel.saleDate).font(.system(.caption))
                Spacer()
            }
        }
    }
}

#Preview {
    SaleDetailView(
        viewModel: SaleDetailViewModel(
            sale: Sale(
                date: .now,
                amount: 133_432.34,
                currencyCode: "ARS"
            ),
            dateFormat: .dateTime,
            currencyConvertion: CurrencyConvertion(
                fromCurrencyCode: "ARS",
                toCurrencyCode: "USD",
                rate: 1 / 1000
            )
        )
    )
}
