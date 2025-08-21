//
//  ProductDetailComposer.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

enum ProductDetailComposer {
    static let dateFormatter = Date.FormatStyle()
        .year(.defaultDigits)
        .month(.abbreviated)
        .day(.defaultDigits)
        .hour(.defaultDigits(amPM: .abbreviated))
        .locale(Locale(identifier: "en_US"))

    static let globalCurrencyCode: String = "USD"

    static func saleViewmodels(
        from product: Product,
        dateformat: Date.FormatStyle,
        currencyCode: String
    )
        -> [SaleDetailViewModel]
    {
        product.sales.map { sale in
            SaleDetailViewModel(
                sale: sale,
                dateFormat: dateFormatter,
                currencyconversion: try? product.currencyConverter.currencyConversion(
                    fromCurrency: sale.currencyCode,
                    toCurrency: globalCurrencyCode
                )
            )
        }.sorted { viewmodel1, viewmodel2 in
            viewmodel1.sale.date > viewmodel2.sale.date
        }
    }

    static func compose(
        with product: Product
    )
        -> ProductSaleDetailListView
    {
        ProductSaleDetailListView(
            saleDetailViews: saleViewmodels(
                from: product,
                dateformat: dateFormatter,
                currencyCode: globalCurrencyCode
            ).map { SaleDetailView(viewModel: $0) },
            headerSection: ProductSalesTotalAmountView(
                viewModel: ProductSalesTotalAmountViewModel(
                    product: product,
                    currencyCode: globalCurrencyCode
                )
            )
        )
    }
}
