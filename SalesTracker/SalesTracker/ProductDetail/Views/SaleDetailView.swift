//
//  SaleDetailView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import SwiftUI

struct SaleDetailView: View {
    let viewModel: SaleDetailViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.localCurrencySaleAmount)
                Spacer()
                Text(viewModel.convertedCurrencySaleAmount)
            }
            HStack {
                Text(viewModel.saleDate)
                Spacer()
            }
        }.padding()
    }
}

#Preview {
    SaleDetailView(
        viewModel: SaleDetailViewModel(
            sale: Sale(
                date: .now,
                amount: 133432.34,
                currencyCode: "ARS"
            ),
            currencyConvertion: CurrencyConvertion(
                fromCurrencyCode: "ARS",
                toCurrencyCode: "USD",
                rate: 1000
            )
        )
    )
}
