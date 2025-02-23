//
//  ProductSalesLoaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 23/2/25.
//

import Testing
@testable import SalesTracker

struct ProductSalesLoader {
    func loadProductsAndSales() async throws -> [Product: [Sale]] {
        throw ProductSalesMapperError.decoding
    }
}

struct ProductSalesLoaderTests {

    @Test func throws_on_load_error() async throws {
        let sut = makeSUT()
        
        await #expect(throws: ProductSalesMapperError.decoding, performing: {
            try await sut.loadProductsAndSales()
        })
    }
    
    @Test func maps_on_products_and_sales_load_success() async throws {
    }

}

extension ProductSalesLoaderTests {
    func makeSUT() -> ProductSalesLoader {
        return ProductSalesLoader()
    }
}
