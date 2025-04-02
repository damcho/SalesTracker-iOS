//
//  ProductSalesTotalAmountViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

struct ProductSalesTotalAmountViewModel {
    var totalSalesAmount: Double {
        product.sales.reduce(0) { partialResult, sale in
            guard sale.currencyCode != "USD" else {
                return partialResult + sale.amount
            }
            let conversionRate = try? product.currencyConverter.currencyConversion(
                fromCurrency: sale.currencyCode,
                toCurrency: currencyCode
            ).rate
            return partialResult + sale.amount * (conversionRate ?? 0)
        }
    }

    let product: Product
    let currencyCode: String

    var productSalesLabelText: String {
        "(\(totalSalesAmount.formatted(.currency(code: currencyCode).presentation(.narrow)))) from \(product.sales.count) sales"
    }
}
