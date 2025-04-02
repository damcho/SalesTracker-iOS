//
//  ProductSaleDetailListView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import SwiftUI

struct ProductSaleDetailListView: View {
    @State var saleDetailViews: [SaleDetailView]
    let headerSection: ProductSalesTotalAmountView

    var body: some View {
        VStack {
            headerSection
            List {
                Section {
                    ForEach(saleDetailViews) { saleDetailView in
                        saleDetailView
                    }
                } header: {
                    Text("Sales Detail")
                }
            }
        }
    }
}

#Preview {
    ProductSaleDetailListView(
        saleDetailViews: [
            SaleDetailView(
                viewModel: SaleDetailViewModel(
                    sale: Sale(
                        date: .now,
                        amount: 134_543.23,
                        currencyCode: "ARS"
                    ),
                    dateFormat: .dateTime,
                    currencyconversion: CurrencyConversion(
                        fromCurrencyCode: "ARS",
                        toCurrencyCode: "USD",
                        rate: 1 / 1000
                    )
                )
            )
        ],
        headerSection: ProductSalesTotalAmountView(
            viewModel: ProductSalesTotalAmountViewModel(
                product: Product(
                    id: UUID(),
                    name: "Product A",
                    sales: [],
                    currencyConverter: CurrencyConverter(currencyconversions: [])
                ),
                currencyCode: "ARS"
            )
        )
    )
}
