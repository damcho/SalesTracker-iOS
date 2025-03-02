//
//  ProductDetailTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation
@testable import SalesTracker
import Testing

struct ProductDetailTests {
    @Test
    func displays_product_total_sales_amount() async throws {
        let sut = ProductSalesTotalAmountViewModel(
            totalSalesAmount: 143_432.3,
            salesCount: 3,
            product: someProduct,
            currencyCode: "USD"
        )

        #expect(sut.productSalesLabelText == "($143,432.30) from 3 sales")
    }

    @Test
    func displays_sale_detail_info() async throws {
        let expectedDate = aDate(for: .dateTime)
        let sut = SaleDetailViewModel(
            sale: Sale(
                date: expectedDate.date,
                amount: 143_432.3,
                currencyCode: "ARS"
            ),
            dateFormat: .dateTime,
            currencyFormat: .narrow,
            currencyConvertion: CurrencyConvertion(
                fromCurrencyCode: "ARS",
                toCurrencyCode: "USD",
                rate: 1 / 1000
            )
        )

        #expect(sut.localCurrencySaleAmount == "$143,432.30")
        #expect(sut.convertedCurrencySaleAmount == "$143.43")
        #expect(sut.saleDate == expectedDate.string)
    }

    @Test
    func total_sales_amount_calculator() async throws {
        let sales = [
            sale(amount: 10, currencyCode: "EUR"),
            sale(amount: 1000, currencyCode: "ARS")
        ]
        let currencyConverter = CurrencyConverter(
            currencyConvertions: [
                CurrencyConvertion(
                    fromCurrencyCode: "EUR", toCurrencyCode: "USD", rate: 1.1
                ),
                CurrencyConvertion(
                    fromCurrencyCode: "ARS", toCurrencyCode: "USD", rate: 1 / 1000
                )
            ]
        )

        let totalSalesAmount = ProductDetailComposer.totalSalesAmountCalculator(
            currencyConverter: currencyConverter,
            sales: sales,
            currencyDestinationCode: "USD"
        )

        #expect(totalSalesAmount == 12.0)
    }

    @Test
    func ignores_sale_amount_on_missing_currency_convertion_rate() async throws {
        let sales = [
            sale(amount: 10, currencyCode: "EUR"),
            sale(amount: 1000, currencyCode: "ARS")
        ]
        let currencyConverter = CurrencyConverter(
            currencyConvertions: [
                CurrencyConvertion(
                    fromCurrencyCode: "EUR", toCurrencyCode: "USD", rate: 1.1
                )
            ]
        )

        let totalSalesAmount = ProductDetailComposer.totalSalesAmountCalculator(
            currencyConverter: currencyConverter,
            sales: sales,
            currencyDestinationCode: "USD"
        )

        #expect(totalSalesAmount == 11)
    }
}

func aDate(for format: Date.FormatStyle) -> (date: Date, string: String) {
    var dateComponents = DateComponents()
    dateComponents.year = 2030
    dateComponents.month = 1
    dateComponents.day = 1
    dateComponents.timeZone = TimeZone(abbreviation: "EST")
    dateComponents.hour = 13
    dateComponents.minute = 0

    return (
        Calendar(identifier: .gregorian).date(from: dateComponents)!,
        Calendar(identifier: .gregorian).date(from: dateComponents)!.formatted(format)
    )
}

func sale(amount: Double, currencyCode: String) -> Sale {
    Sale(date: .now, amount: amount, currencyCode: currencyCode)
}
