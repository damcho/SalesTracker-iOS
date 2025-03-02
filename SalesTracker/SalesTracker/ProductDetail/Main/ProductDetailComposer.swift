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

    static func totalSalesAmountCalculator(
        currencyConverter: CurrencyConverter,
        sales: [Sale],
        currencyDestinationCode: String
    )
        -> Double
    {
        sales.reduce(0) { partialResult, sale in
            let convertionRate = try? currencyConverter.currencyConvertion(
                fromCurrency: sale.currencyCode,
                toCurrency: currencyDestinationCode
            ).rate
            return partialResult + sale.amount * (convertionRate ?? 0)
        }
    }

    static func compose(
        with product: Product,
        sales: [Sale],
        currencyConverter: CurrencyConverter
    )
        -> ProductSaleDetailListView
    {
        let headerSection = ProductSalesTotalAmountView(
            viewModel: ProductSalesTotalAmountViewModel(
                totalSalesAmount: totalSalesAmountCalculator(
                    currencyConverter: currencyConverter,
                    sales: sales,
                    currencyDestinationCode: globalCurrencyCode
                ),
                salesCount: sales.count,
                product: product,
                currencyCode: globalCurrencyCode
            )
        )
        let saleDetailViews: [SaleDetailView] = sales.map { sale in
            SaleDetailView(
                viewModel: SaleDetailViewModel(
                    sale: sale,
                    dateFormat: dateFormatter,
                    currencyConvertion: try? currencyConverter.currencyConvertion(
                        fromCurrency: sale.currencyCode,
                        toCurrency: globalCurrencyCode
                    )
                )
            )
        }
        return ProductSaleDetailListView(
            saleDetailViews: saleDetailViews,
            headerSection: headerSection
        )
    }
}
