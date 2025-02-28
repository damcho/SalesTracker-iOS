//
//  CurrencyConverterTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 28/2/25.
//

import Testing

struct CurrencyConvertion {
    let fromCurrencyCode: String
    let toCurrencyCode: String
    let rate: Double
}

struct CurrencyConverter {
    var currencyConvertionsMap: [String: [String: Double]] = [:]
    init(currencyConvertions: [CurrencyConvertion]) {
        currencyConvertions.forEach { currencyConvertion in
            if currencyConvertionsMap[currencyConvertion.fromCurrencyCode] != nil {
                currencyConvertionsMap[currencyConvertion.fromCurrencyCode]?[currencyConvertion.toCurrencyCode] = currencyConvertion.rate
            } else {
                currencyConvertionsMap[currencyConvertion.fromCurrencyCode] = [currencyConvertion.toCurrencyCode: currencyConvertion.rate]
            }
            
            if currencyConvertionsMap[currencyConvertion.toCurrencyCode] != nil {
                currencyConvertionsMap[currencyConvertion.toCurrencyCode]?[currencyConvertion.fromCurrencyCode] = 1 / currencyConvertion.rate
            } else {
                currencyConvertionsMap[currencyConvertion.toCurrencyCode] = [currencyConvertion.fromCurrencyCode: 1 / currencyConvertion.rate]
            }
        }
    }
}

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
}

extension CurrencyConverterTests {
    func assert(_ expectedConvertionsMap: [String: [String: Double]], for conversionsMap: [String: [String: Double]]) {
    }
}
