//
//  RemoteCurrencyRatesLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 1/3/25.
//

import Foundation

typealias RemoteCurrencyRatesLoader = RemoteGetLoader<[CurrencyConversion]>

// MARK: - RemoteGetLoader + RemoteCurrencyRatesLoadable

extension RemoteGetLoader: RemoteCurrencyRatesLoadable where ObjectType == [CurrencyConversion] {
    func loadCurrencyRates() async throws -> CurrencyConverter {
        try await CurrencyConverter(
            currencyconversions: performGetRequest()
        )
    }
}
