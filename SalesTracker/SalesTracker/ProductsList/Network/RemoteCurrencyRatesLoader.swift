//
//  RemoteCurrencyRatesLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 1/3/25.
//

import Foundation

typealias RemoteCurrencyRatesMapper = ((data: Data, httpResponse: HTTPURLResponse)) throws -> [CurrencyConvertion]

struct RemoteCurrencyRatesLoader {
    let httpCLient: SalesTrackerHTTPClient
    let url: URL
    let mapper: RemoteCurrencyRatesMapper
    
    func loadCurrencyRates() async throws -> CurrencyConverter {
        try await CurrencyConverter(
            currencyConvertions: mapper(httpCLient.get(from: url))
        )
    }
}
