//
//  ProductDetailTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 28/2/25.
//

import Testing
@testable import SalesTracker
struct ProductDetailTests {

    @Test func displays_product_total_sales_amount() async throws {
        let sut = ProductSalesTotalAmountViewModel(
            totalSalesAmount: 143432.3,
            salesCount: 3,
            product: someProduct,
            currencyCode: "USD"
        )
        
        #expect(sut.productSalesLabelText == "($143,432.30) from 3 sales")
    }

}
