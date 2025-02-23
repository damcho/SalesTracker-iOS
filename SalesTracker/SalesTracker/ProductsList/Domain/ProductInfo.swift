//
//  ProductInfo.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation

struct Sale: Equatable {
    let date: Date
    let amount: Double
    let currencyCode: String
}

struct ProductInfo {
    let productId: UUID
    let name: String
    let salesCount: Int
}
