//
//  RemoteCurrencyRatesLoaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 1/3/25.
//

import Testing
@testable import SalesTracker
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

struct RemoteCurrencyRatesLoaderTests {

    @Test func throws_on_currency_rates_load_error() async throws {
        let sut = makeSUT(httpCLientStub: .failure(anyError))
        
        await #expect(throws: anyError, performing: {
            try await sut.loadCurrencyRates()
        })
    }
    
    @Test func returns_mapped_currency_rates_on_load_success() async throws {
        let sut = makeSUT(
            httpCLientStub: .success((currencyRate.http, successfulHTTPResponse)),
            mapper: {_ in
                [currencyRate.decoded]
            }
        )

        #expect(try await sut.loadCurrencyRates() == currencyRate.domain)
    }

}

extension RemoteCurrencyRatesLoaderTests {
    func makeSUT(
        httpCLientStub: HTTPResult,
        mapper: @escaping RemoteCurrencyRatesMapper = {_ in throw anyError }
    ) -> RemoteCurrencyRatesLoader {
        return RemoteCurrencyRatesLoader(
            httpCLient: HTTPClientStub(stub: httpCLientStub),
            url: anyURL,
            mapper: mapper
        )
    }
}

var currencyRate: (http: Data, decoded: CurrencyConvertion, domain: CurrencyConverter) {
    (
        #"[{"from": "USD","to": "EUR","rate": 0.89}]"#.data(using: .utf8)!,
        CurrencyConvertion(
            fromCurrencyCode: "USD",
            toCurrencyCode: "EUR",
            rate: 0.89
        ),
        .init(currencyConvertions: [
            .init(fromCurrencyCode: "USD", toCurrencyCode: "EUR", rate: 0.89)
        ])
    )
}
