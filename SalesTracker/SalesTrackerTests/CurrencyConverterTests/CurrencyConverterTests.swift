//
//  CurrencyConverterTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 28/2/25.
//

import Testing

struct CurrencyConvertion: Hashable {
    let fromCurrencyCode: String
    let toCurrencyCode: String
    let rate: Double
}

struct CurrencyConverter {
    var currencyConvertionsSet = Set<CurrencyConvertion>()
    init(currencyConvertions: [CurrencyConvertion]) {
        currencyConvertions.forEach { currencyConvertion in
            currencyConvertionsSet.insert(currencyConvertion)
            currencyConvertionsSet.insert(
                CurrencyConvertion(
                    fromCurrencyCode: currencyConvertion.toCurrencyCode,
                    toCurrencyCode: currencyConvertion.fromCurrencyCode,
                    rate: 1 / currencyConvertion.rate
                )
            )
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
        
        let expectedConvertions = Set(
            initialConvertionss +
            [CurrencyConvertion(
                fromCurrencyCode: "AUD",
                toCurrencyCode: "USD",
                rate: 1 / 1.1
            ),
             CurrencyConvertion(
                fromCurrencyCode: "ARS",
                toCurrencyCode: "USD",
                rate: 1 / 1000
             )])
        
        let sut = CurrencyConverter(currencyConvertions: initialConvertionss)
        #expect(sut.currencyConvertionsSet == expectedConvertions)
    }
}

extension CurrencyConverterTests {
    func assert(_ expectedConvertionsMap: [String: [String: Double]], for conversionsMap: [String: [String: Double]]) {
    }
}
