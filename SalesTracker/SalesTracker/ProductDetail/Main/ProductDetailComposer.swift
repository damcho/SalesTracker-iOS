//
//  ProductDetailComposer.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

enum ProductDetailComposer {
    static let globalCurrencyCode: String = "USD"
    static func compose(
        with product: Product,
        sales: [Sale],
        currencyConverter: CurrencyConverter
    ) -> ProductSaleDetailListView {
        let headerSection = ProductSalesTotalAmountView(
            viewModel: ProductSalesTotalAmountViewModel(
                totalSalesAmount: sales.reduce(0, { partialResult, sale in
                    try! partialResult + sale.amount * currencyConverter.currencyConvertion(
                        fromCurrency: sale.currencyCode,
                        toCurrency: globalCurrencyCode
                    ).rate
                }),
                salesCount: sales.count,
                product: product,
                currencyCode: globalCurrencyCode
            )
        )
        let saleDetailViews: [SaleDetailView] = sales.map { sale in
            SaleDetailView(
                viewModel: SaleDetailViewModel(
                    sale: sale,
                    currencyConvertion: try! currencyConverter.currencyConvertion(
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
