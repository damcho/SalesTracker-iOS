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
                ForEach(saleDetailViews) { saleDetailView in
                    saleDetailView
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
                totalSalesAmount: 134_434,
                salesCount: 23,
                product: Product(
                    id: UUID(),
                    name: "Product A",
                    sales: []
                ),
                currencyCode: "ARS"
            )
        )
    )
}
