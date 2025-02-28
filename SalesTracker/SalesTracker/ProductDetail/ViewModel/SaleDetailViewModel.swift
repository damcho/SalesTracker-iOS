//
//  SaleDetailViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

struct SaleDetailViewModel {
    let sale: Sale
    let currencyConvertion: CurrencyConvertion
    
    var saleDate: String {
        sale.date.formatted(
            Date.FormatStyle()
                .year(.defaultDigits)
                .month(.abbreviated)
                .day(.defaultDigits)
                .hour(.defaultDigits(amPM: .abbreviated))
                .minute(.omitted)
                .locale(Locale(identifier: "en_US"))
        )
    }
    
    var localCurrencySaleAmount: String {
        "\(sale.amount.formatted(.currency(code: sale.currencyCode).presentation(.standard)))"
    }
    
    var convertedCurrencySaleAmount: String {
        let convertedAmount = sale.amount * currencyConvertion.rate
        return "\(convertedAmount.formatted(.currency(code: currencyConvertion.toCurrencyCode).presentation(.standard)))"

    }
}
