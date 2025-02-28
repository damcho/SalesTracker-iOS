//
//  CurrencyConverter.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

struct CurrencyConvertion {
    let fromCurrencyCode: String
    let toCurrencyCode: String
    let rate: Double
}

enum CurrencyConverterError: Error {
    case missingRate
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
    
    func convert(amount: Double, fromCurrency: String, toCurrency: String) throws -> Double {
        guard let arate = currencyConvertionsMap[fromCurrency]?[toCurrency] else {
            throw CurrencyConverterError.missingRate
        }
        return amount * arate
    }
}
