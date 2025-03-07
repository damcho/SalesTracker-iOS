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
    let currencyFormat: CurrencyFormatStyleConfiguration.Presentation
    init(
        sale: Sale,
        dateFormat: Date.FormatStyle,
        currencyFormat: CurrencyFormatStyleConfiguration.Presentation = .standard,
        currencyConvertion: CurrencyConvertion?
    ) {
        self.sale = sale
        self.currencyConvertion = currencyConvertion
        self.dateFormat = dateFormat
        self.currencyFormat = currencyFormat
    }

    var saleDate: String {
        sale.date.formatted(
            dateFormat
        )
    }

    var localCurrencySaleAmount: String {
        "\(sale.amount.formatted(.currency(code: sale.currencyCode).presentation(currencyFormat)))"
    }

    var convertedCurrencySaleAmount: String {
        guard let aCurrencyConvertion = currencyConvertion else {
            return localCurrencySaleAmount
        }
        let convertedAmount = sale.amount * aCurrencyConvertion.rate
        return "\(convertedAmount.formatted(.currency(code: aCurrencyConvertion.toCurrencyCode).presentation(currencyFormat)))"
    }
}
