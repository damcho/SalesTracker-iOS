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

        let totalSalesAmount = ProductDetailComposer.calculateTotalSalesAmount(
            from: currencyConverter,
            sales: sales,
            currencyCode: "USD"
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

        let totalSalesAmount = ProductDetailComposer.calculateTotalSalesAmount(
            from: currencyConverter,
            sales: sales,
            currencyCode: "USD"
        )

        #expect(totalSalesAmount == 11)
    }

    @Test
    func orders_sales_viewmodels_by_date_asc() async throws {
        let saleJustNow = sale(date: .now)
        let saleTenSecondsAgo = sale(date: .now - 10)

        let expectedViewModelsOrder = [
            saleViewModel(with: saleJustNow),
            saleViewModel(with: saleTenSecondsAgo)
        ]
        let createdViewModels = ProductDetailComposer.saleViewmodels(
            from: [
                saleTenSecondsAgo,
                saleJustNow
            ],
            currencyConverter: CurrencyConverter(currencyConvertions: []),
            dateformat: .dateTime,
            currencyCode: "USD"
        )
        assertOrder(for: createdViewModels, with: expectedViewModelsOrder)
    }

    @Test
    func displays_local_currency_on_missing_conversion_rate() async throws {
        let expectedDate = aDate(for: .dateTime)
        let sut = SaleDetailViewModel(
            sale: Sale(
                date: expectedDate.date,
                amount: 143_432.3,
                currencyCode: "ARS"
            ),
            dateFormat: .dateTime,
            currencyFormat: .narrow,
            currencyConvertion: nil
        )

        #expect(sut.localCurrencySaleAmount == "$143,432.30")
        #expect(sut.convertedCurrencySaleAmount == "$143,432.30")
    }

    func assertOrder(for createdViewModels: [SaleDetailViewModel], with expectedViewModels: [SaleDetailViewModel]) {
        #expect(createdViewModels.map { $0.sale } == expectedViewModels.map { $0.sale })
    }
}

func saleViewModel(with sale: Sale) -> SaleDetailViewModel {
    .init(
        sale: sale,
        dateFormat: .dateTime,
        currencyConvertion: nil
    )
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

func sale(date: Date = .now, amount: Double = 1, currencyCode: String = "USD") -> Sale {
    Sale(date: date, amount: amount, currencyCode: currencyCode)
}
