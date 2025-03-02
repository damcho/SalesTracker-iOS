//
//  CurrencyConverter.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

struct CurrencyConvertion: Equatable {
    let fromCurrencyCode: String
    let toCurrencyCode: String
    let rate: Double
}

enum CurrencyConverterError: Error {
    case missingRate
}

struct CurrencyConverter: Equatable, Hashable {
    var currencyConvertionsMap: [String: [String: Double]] = [:]
    init(currencyConvertions: [CurrencyConvertion]) {
        for currencyConvertion in currencyConvertions {
            if currencyConvertionsMap[currencyConvertion.fromCurrencyCode] != nil {
                currencyConvertionsMap[currencyConvertion.fromCurrencyCode]?[currencyConvertion.toCurrencyCode] =
                    currencyConvertion.rate
            } else {
                currencyConvertionsMap[currencyConvertion.fromCurrencyCode] =
                    [currencyConvertion.toCurrencyCode: currencyConvertion.rate]
            }

            if currencyConvertionsMap[currencyConvertion.toCurrencyCode] != nil {
                currencyConvertionsMap[currencyConvertion.toCurrencyCode]?[currencyConvertion.fromCurrencyCode] = 1 /
                    currencyConvertion.rate
            } else {
                currencyConvertionsMap[currencyConvertion.toCurrencyCode] =
                    [currencyConvertion.fromCurrencyCode: 1 / currencyConvertion.rate]
            }
        }
    }

    func currencyConvertion(fromCurrency: String, toCurrency: String) throws -> CurrencyConvertion {
        guard let aConvertionRate = currencyConvertionsMap[fromCurrency]?[toCurrency] else {
            throw CurrencyConverterError.missingRate
        }
        return CurrencyConvertion(
            fromCurrencyCode: fromCurrency,
            toCurrencyCode: toCurrency,
            rate: aConvertionRate
        )
    }

    func convert(amount: Double, fromCurrency: String, toCurrency: String) throws -> Double {
        guard let arate = currencyConvertionsMap[fromCurrency]?[toCurrency] else {
            throw CurrencyConverterError.missingRate
        }
        return amount * arate
    }
}
