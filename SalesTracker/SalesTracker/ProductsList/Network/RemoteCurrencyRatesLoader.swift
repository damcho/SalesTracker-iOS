//
//  RemoteCurrencyRatesLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 1/3/25.
//

import Foundation

typealias RemoteCurrencyRatesLoader = RemoteGetLoader<[CurrencyConvertion]>

// MARK: - RemoteGetLoader + RemoteCurrencyRatesLoadable

extension RemoteGetLoader: RemoteCurrencyRatesLoadable where ObjectType == [CurrencyConvertion] {
    func loadCurrencyRates() async throws -> CurrencyConverter {
        try await CurrencyConverter(
            currencyConvertions: performGetRequest()
        )
    }
}
