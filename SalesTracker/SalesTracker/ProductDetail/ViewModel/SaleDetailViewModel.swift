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
        "\(sale.date)"
    }
    
    var localCurrencySaleAmount: String {
        "\(sale.amount)"
    }
    
    var convertedCurrencySaleAmount: String {
        ""
    }
}
