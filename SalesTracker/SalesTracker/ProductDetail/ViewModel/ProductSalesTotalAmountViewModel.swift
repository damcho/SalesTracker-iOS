//
//  ProductSalesTotalAmountViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

struct ProductSalesTotalAmountViewModel {
    let totalSalesAmount: Double
    let salesCount: Int
    let product: Product
    let currencyCode: String

    var productSalesLabelText: String {
        "(\(totalSalesAmount.formatted(.currency(code: currencyCode).presentation(.narrow)))) from \(salesCount) sales"
    }
}
