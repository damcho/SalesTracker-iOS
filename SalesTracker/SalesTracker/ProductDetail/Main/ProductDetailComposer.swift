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
        .minute(.omitted)
        .locale(Locale(identifier: "en_US"))

    static let globalCurrencyCode: String = "USD"

    static func calculateTotalSalesAmount(
        from currencyConverter: CurrencyConverter,
        sales: [Sale],
        currencyCode: String
    )
        -> Double
    {
        sales.reduce(0) { partialResult, sale in
            let convertionRate = try? currencyConverter.currencyConvertion(
                fromCurrency: sale.currencyCode,
                toCurrency: currencyCode
            ).rate
            return partialResult + sale.amount * (convertionRate ?? 0)
        }
    }

    static func saleViewmodels(
        from sales: [Sale],
        currencyConverter: CurrencyConverter,
        dateformat: Date.FormatStyle,
        currencyCode: String
    )
        -> [SaleDetailViewModel]
    {
        sales.map { sale in
            SaleDetailViewModel(
                sale: sale,
                dateFormat: dateFormatter,
                currencyConvertion: try? currencyConverter.currencyConvertion(
                    fromCurrency: sale.currencyCode,
                    toCurrency: globalCurrencyCode
                )
            )
        }.sorted { viewmodel1, viewmodel2 in
            viewmodel1.sale.date > viewmodel2.sale.date
        }
    }

    static func compose(
        with product: Product,
        sales: [Sale],
        currencyConverter: CurrencyConverter
    )
        -> ProductSaleDetailListView
    {
        ProductSaleDetailListView(
            saleDetailViews: saleViewmodels(
                from: sales,
                currencyConverter: currencyConverter,
                dateformat: dateFormatter,
                currencyCode: globalCurrencyCode
            ).map { SaleDetailView(viewModel: $0) },
            headerSection: ProductSalesTotalAmountView(
                viewModel: ProductSalesTotalAmountViewModel(
                    totalSalesAmount: calculateTotalSalesAmount(
                        from: currencyConverter,
                        sales: sales,
                        currencyCode: globalCurrencyCode
                    ),
                    salesCount: sales.count,
                    product: product,
                    currencyCode: globalCurrencyCode
                )
            )
        )
    }
}
