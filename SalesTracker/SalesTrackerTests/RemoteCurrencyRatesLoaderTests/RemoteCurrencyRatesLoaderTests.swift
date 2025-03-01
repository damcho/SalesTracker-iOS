//
//  RemoteCurrencyRatesLoaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 1/3/25.
//

import Testing
@testable import SalesTracker

struct RemoteCurrencyRatesLoader {
    func loadCurrencyRates() async throws -> CurrencyConverter {
        throw anyError
    }
}

struct RemoteCurrencyRatesLoaderTests {

    @Test func throws_on_currency_rates_load_error() async throws {
        let sut = makeSUT(httpCLientStub: .failure(anyError))
        
        await #expect(throws: anyError, performing: {
            try await sut.loadCurrencyRates()
        })
    }

}

extension RemoteCurrencyRatesLoaderTests {
    func makeSUT(
        httpCLientStub: HTTPResult
    ) -> RemoteCurrencyRatesLoader {
        return RemoteCurrencyRatesLoader(
          
        )
    }
}
