//
//  ProductInfo.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation

struct RemoteSale: Equatable {
    let productID: UUID
    let date: Date
    let amount: Double
    let currencyCode: String
}

struct ProductInfo {
    let productId: UUID
    let name: String
    let sales: [RemoteSale]
}
