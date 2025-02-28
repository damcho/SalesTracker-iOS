//
//  ProductDetailTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 28/2/25.
//

import Testing
@testable import SalesTracker
import Foundation

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
    
    @Test func displays_sale_detail_info() async throws {
        let sut = SaleDetailViewModel(
            sale: Sale(
                date: aDate.date,
                amount: 143432.3,
                currencyCode: "ARS"
            ),
            currencyConvertion: CurrencyConvertion(
                fromCurrencyCode: "ARS",
                toCurrencyCode: "USD",
                rate: 1 / 1000
            )
        )
        
        #expect(sut.localCurrencySaleAmount == "ARS 143,432.30")
        #expect(sut.convertedCurrencySaleAmount == "US$143.43")
        #expect(sut.saleDate == aDate.string)
        print(sut.saleDate)
        print(aDate.string)
    }
}

var aDate: (date: Date, string: String) {
    var dateComponents = DateComponents()
    dateComponents.year = 2030
    dateComponents.month = 1
    dateComponents.day = 1
    dateComponents.timeZone = TimeZone(abbreviation: "EST")
    dateComponents.hour = 13
    dateComponents.minute = 0

    return (
        Calendar(identifier: .gregorian).date(from: dateComponents)!,
        "Jan 1, 2030 at 3 PM"
    )
}
