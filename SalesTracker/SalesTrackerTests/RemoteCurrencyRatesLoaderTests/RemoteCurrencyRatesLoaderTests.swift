//
//  RemoteCurrencyRatesLoaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 1/3/25.
//

import Foundation
@testable import SalesTracker
import Testing

struct RemoteCurrencyRatesLoaderTests {
    @Test
    func throws_on_currency_rates_load_error() async throws {
        let sut = makeSUT(httpCLientStub: .failure(anyError))

        await #expect(throws: anyError, performing: {
            try await sut.loadCurrencyRates()
        })
    }

    @Test
    func returns_mapped_currency_rates_on_load_success() async throws {
        let sut = makeSUT(
            httpCLientStub: .success((currencyRate.http, successfulHTTPResponse)),
            mapper: { _ in
                [currencyRate.decoded]
            }
        )

        #expect(try await sut.loadCurrencyRates() == currencyRate.domain)
    }
}

extension RemoteCurrencyRatesLoaderTests {
    func makeSUT(
        httpCLientStub: HTTPResult,
        mapper: @escaping RemoteCurrencyRatesMapper = { _ in throw anyError }
    )
        -> RemoteCurrencyRatesLoader
    {
        RemoteCurrencyRatesLoader(
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
