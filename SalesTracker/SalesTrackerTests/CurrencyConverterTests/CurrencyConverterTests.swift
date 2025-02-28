//
//  CurrencyConverterTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 28/2/25.
//

import Testing
@testable import SalesTracker
struct CurrencyConverterTests {

    @Test func creates_all_convertion_rates_couples_on_init() async throws {
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
        print(sut.currencyConvertionsMap)
        #expect(sut.currencyConvertionsMap == expectedConvertionsMap)
    }
    
    @Test func throws_on_missing_convertion_rate() async throws {
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
            try sut.convert(amount: 123.4, fromCurrency: "EUR", toCurrency: "USD")
        })
    }
    
    @Test func converts_currency_successfully() async throws {
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

        let convertedAmount = try sut.convert(amount: 10, fromCurrency: "USD", toCurrency: "ARS")

        #expect(convertedAmount == 10000)
    }
}

extension CurrencyConverterTests {
    func assert(_ expectedConvertionsMap: [String: [String: Double]], for conversionsMap: [String: [String: Double]]) {
    }
}
