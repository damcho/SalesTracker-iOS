//
//  SaleDetailViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

struct SaleDetailViewModel {
    let sale: Sale
    let currencyConvertion: CurrencyConvertion?
    let dateFormat: Date.FormatStyle

    init(
        sale: Sale,
        dateFormat: Date.FormatStyle,
        currencyConvertion: CurrencyConvertion?
    ) {
        self.sale = sale
        self.currencyConvertion = currencyConvertion
        self.dateFormat = dateFormat
    }

    var saleDate: String {
        sale.date.formatted(
            dateFormat
        )
    }

    var localCurrencySaleAmount: String {
        "\(sale.amount.formatted(.currency(code: sale.currencyCode).presentation(.standard)))"
    }

    var convertedCurrencySaleAmount: String {
        guard let aCurrencyConvertion = currencyConvertion else {
            return "N/A"
        }
        let convertedAmount = sale.amount * aCurrencyConvertion.rate
        return "\(convertedAmount.formatted(.currency(code: aCurrencyConvertion.toCurrencyCode).presentation(.standard)))"
    }
}
