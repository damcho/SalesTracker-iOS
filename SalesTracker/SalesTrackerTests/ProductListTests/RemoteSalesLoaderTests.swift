//
//  RemoteSalesLoaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation
@testable import SalesTracker
import Testing

struct RemoteSalesLoaderTests {
    @Test
    func throws_on_products_load_error() async throws {
        let sut = makeSUT(httpCLientStub: .failure(anyError))

        await #expect(throws: anyError, performing: {
            try await sut.loadSales()
        })
    }

    @Test
    func returns_mapped_products_on_load_success() async throws {
        let sut = makeSUT(
            httpCLientStub: .success((productListData.http, successfulHTTPResponse)),
            mapper: { _ in
                salesList.decoded
            }
        )

        #expect(try await sut.loadSales() == salesList.decoded)
    }
}

extension RemoteSalesLoaderTests {
    func makeSUT(
        httpCLientStub: HTTPResult,
        mapper: @escaping RemoteSalesListMapper = { _ in throw anyError }
    )
        -> RemoteSalesLoadable
    {
        RemoteSalesLoader(
            httpClient: HTTPClientStub(stub: httpCLientStub),
            url: anyURL,
            mapper: mapper
        )
    }
}
