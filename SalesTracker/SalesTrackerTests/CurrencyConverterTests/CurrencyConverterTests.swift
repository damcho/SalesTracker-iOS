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
    func creates_all_convertion_rates_couples_on_init() async throws {
        let initialConvertionss = [
            CurrencyConvertion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "AUD",
                rate: 1.1
            ),
            CurrencyConvertion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "ARS",
                rate: 1000
            )
        ]

        let expectedConvertionsMap: [String: [String: Double]] = [
            "USD": [
                "AUD": 1.1,
                "ARS": 1000
            ],
            "AUD": [
                "USD": 1 / 1.1
            ],
            "ARS": [
                "USD": 1 / 1000
            ]
        ]

        let sut = CurrencyConverter(currencyConvertions: initialConvertionss)
        #expect(sut.currencyConvertionsMap == expectedConvertionsMap)
    }

    @Test
    func returns_currency_convertion_successfully() async throws {
        let initialConvertionss = [
            CurrencyConvertion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "AUD",
                rate: 1.1
            ),
            CurrencyConvertion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "ARS",
                rate: 1000
            )
        ]

        let sut = CurrencyConverter(currencyConvertions: initialConvertionss)

        #expect(
            try sut
                .currencyConvertion(fromCurrency: "USD", toCurrency: "AUD") ==
                CurrencyConvertion(fromCurrencyCode: "USD", toCurrencyCode: "AUD", rate: 1.1)
        )
    }

    @Test
    func throws_on_missing_currency_rate() async throws {
        let missigCurrency = "EUR"
        let initialConvertionss = [
            CurrencyConvertion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "AUD",
                rate: 1.1
            ),
            CurrencyConvertion(
                fromCurrencyCode: "USD",
                toCurrencyCode: "ARS",
                rate: 1000
            )
        ]

        let sut = CurrencyConverter(currencyConvertions: initialConvertionss)

        #expect(throws: CurrencyConverterError.missingRate, performing: {
            try sut.currencyConvertion(fromCurrency: missigCurrency, toCurrency: "USD")
        })
    }
}

extension CurrencyConverterTests {
    func assert(_: [String: [String: Double]], for _: [String: [String: Double]]) {}
}
