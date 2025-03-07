//
//  Sale.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

struct Sale: Equatable, Hashable {
    let date: Date
    let amount: Double
    let currencyCode: String
}
