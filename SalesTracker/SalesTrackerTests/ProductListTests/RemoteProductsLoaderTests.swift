//
//  RemoteProductsLoaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 23/2/25.
//

import Testing
@testable import SalesTracker
import Foundation

struct RemoteProductsLoaderTests {

    @Test func throws_on_products_load_error() async throws {
        let sut = makeSUT(httpCLientStub: .failure(anyError))
        
        await #expect(throws: anyError, performing: {
            try await sut.loadProducts()
        })
    }
    
    @Test func returns_mapped_products_on_load_success() async throws {
        let sut = makeSUT(
            httpCLientStub: .success((productListData.http, successfulHTTPResponse)),
            mapper: {_ in
                productListData.decoded
            }
        )

        #expect(try await sut.loadProducts() == productListData.decoded)
    }
}

extension RemoteProductsLoaderTests {
    func makeSUT(
        httpCLientStub: HTTPResult,
        mapper: @escaping RemoteProductsListMapper = {_ in throw anyError }
    ) -> RemoteProductsLoader {
        return RemoteProductsLoader(
            httpClient: HTTPClientStub(stub: httpCLientStub),
            url: anyURL,
            mapper: mapper
        )
    }
}
