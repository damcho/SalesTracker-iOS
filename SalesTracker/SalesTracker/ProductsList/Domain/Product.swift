//
//  Product.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation

struct Product {
    let id: UUID
    let name: String
    let sales: [Sale]
    let currencyConverter: CurrencyConverter
}
