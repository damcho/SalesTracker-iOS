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
    
    init(sale: Sale, currencyConvertion: CurrencyConvertion?) {
        self.sale = sale
        self.currencyConvertion = currencyConvertion
    }
    
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
        guard let aCurrencyConvertion = currencyConvertion else {
            return "N/A"
        }
        let convertedAmount = sale.amount * aCurrencyConvertion.rate
        return "\(convertedAmount.formatted(.currency(code: aCurrencyConvertion.toCurrencyCode).presentation(.standard)))"
    }
}
