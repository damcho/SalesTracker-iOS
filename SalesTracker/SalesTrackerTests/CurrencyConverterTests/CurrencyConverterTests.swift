//
//  CurrencyConverterTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 28/2/25.
//

@testable import SalesTracker
import Testing

struct CurrencyConverterTests {
    @Test
    func maps_conversion_rates_on_init() async throws {
        let initialconversionss = [
            CurrencyConversion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "AUD",
                rate: 1.1
            ),
            CurrencyConversion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "ARS",
                rate: 1000
            )
        ]

        let expectedconversionsMap: [String: [String: Double]] = [
            "USD": [
                "AUD": 1.1,
                "ARS": 1000
            ]
        ]

        let sut = CurrencyConverter(currencyconversions: initialconversionss)
        #expect(sut.currencyconversionsMap == expectedconversionsMap)
    }

    @Test
    func returns_currency_conversion_successfully() async throws {
        let initialconversionss = [
            CurrencyConversion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "AUD",
                rate: 1.1
            ),
            CurrencyConversion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "ARS",
                rate: 1000
            )
        ]

        let sut = CurrencyConverter(currencyconversions: initialconversionss)

        #expect(
            try sut
                .currencyConversion(fromCurrency: "USD", toCurrency: "AUD") ==
                CurrencyConversion(fromCurrencyCode: "USD", toCurrencyCode: "AUD", rate: 1.1)
        )
    }

    @Test
    func throws_on_missing_currency_rate() async throws {
        let missigCurrency = "EUR"
        let initialconversionss = [
            CurrencyConversion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "AUD",
                rate: 1.1
            ),
            CurrencyConversion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "ARS",
                rate: 1000
            )
        ]

        let sut = CurrencyConverter(currencyconversions: initialconversionss)

        #expect(throws: CurrencyConverterError.missingRate, performing: {
            try sut.currencyConversion(fromCurrency: missigCurrency, toCurrency: "USD")
        })
    }
}
