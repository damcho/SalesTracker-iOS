//
//  CurrencyConverter.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

struct CurrencyConversion: Equatable {
    let fromCurrencyCode: String
    let toCurrencyCode: String
    let rate: Double
}

enum CurrencyConverterError: Error {
    case missingRate
}

struct CurrencyConverter: Equatable, Hashable {
    var currencyconversionsMap: [String: [String: Double]] = [:]
    init(currencyconversions: [CurrencyConversion]) {
        for currencyconversion in currencyconversions {
            if currencyconversionsMap[currencyconversion.fromCurrencyCode] != nil {
                currencyconversionsMap[currencyconversion.fromCurrencyCode]?[currencyconversion.toCurrencyCode] =
                    currencyconversion.rate
            } else {
                currencyconversionsMap[currencyconversion.fromCurrencyCode] =
                    [currencyconversion.toCurrencyCode: currencyconversion.rate]
            }

            if currencyconversionsMap[currencyconversion.toCurrencyCode] != nil {
                currencyconversionsMap[currencyconversion.toCurrencyCode]?[currencyconversion.fromCurrencyCode] = 1 /
                    currencyconversion.rate
            } else {
                currencyconversionsMap[currencyconversion.toCurrencyCode] =
                    [currencyconversion.fromCurrencyCode: 1 / currencyconversion.rate]
            }
        }
    }

    func currencyConversion(fromCurrency: String, toCurrency: String) throws -> CurrencyConversion {
        guard let aconversionRate = currencyconversionsMap[fromCurrency]?[toCurrency] else {
            throw CurrencyConverterError.missingRate
        }
        return CurrencyConversion(
            fromCurrencyCode: fromCurrency,
            toCurrencyCode: toCurrency,
            rate: aconversionRate
        )
    }
}
