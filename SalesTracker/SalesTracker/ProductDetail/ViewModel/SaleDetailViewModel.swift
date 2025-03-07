//
//  SaleDetailViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

struct SaleDetailViewModel {
    let sale: Sale
    let currencyconversion: CurrencyConversion?
    let dateFormat: Date.FormatStyle
    let currencyFormat: CurrencyFormatStyleConfiguration.Presentation
    init(
        sale: Sale,
        dateFormat: Date.FormatStyle,
        currencyFormat: CurrencyFormatStyleConfiguration.Presentation = .standard,
        currencyconversion: CurrencyConversion?
    ) {
        self.sale = sale
        self.currencyconversion = currencyconversion
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
        guard let aCurrencyconversion = currencyconversion else {
            return localCurrencySaleAmount
        }
        let convertedAmount = sale.amount * aCurrencyconversion.rate
        return "\(convertedAmount.formatted(.currency(code: aCurrencyconversion.toCurrencyCode).presentation(currencyFormat)))"
    }
}
