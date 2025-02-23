//
//  RemoteProductsLoaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 23/2/25.
//

import Testing
@testable import SalesTracker

struct RemoteProductsLoader {
    func loadProducts() async throws -> [DecodableProduct] {
        throw anyError
    }
}

struct RemoteProductsLoaderTests {

    @Test func throws_on_products_load_error() async throws {
        let sut = makeSUT()
        
        await #expect(throws: anyError, performing: {
            try await sut.loadProducts()
        })
    }

}

extension RemoteProductsLoaderTests {
    func makeSUT() -> RemoteProductsLoader {
        return RemoteProductsLoader()
    }
}
