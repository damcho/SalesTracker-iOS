//
//  ProductSalesLoaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 23/2/25.
//

import Testing
@testable import SalesTracker

struct ProductSalesLoaderTests {

    @Test func throws_on_load_products_error() async throws {
        let sut = makeSUT(
            productsLoadableStub: .failure(anyError)
        )
        
        await #expect(throws: anyError, performing: {
            try await sut.loadProductsAndSales()
        })
    }
    
    @Test func throws_on_load_sales_error() async throws {
        let sut = makeSUT(
            salesLoadableStub: .failure(anyError)
        )
        
        await #expect(throws: anyError, performing: {
            try await sut.loadProductsAndSales()
        })
    }
    
    @Test func maps_on_products_and_sales_load_success() async throws {
        var mappedResultsCallCount = 0
        let sut = makeSUT(mapper: {_ ,_ in
            mappedResultsCallCount += 1
            return [:]
        })
      
        _ = try await sut.loadProductsAndSales()
        
        #expect(mappedResultsCallCount == 1)
    }
}

extension ProductSalesLoaderTests {
    func makeSUT(
        mapper: @escaping ProductSalesDictionaryMapper = {_, _ in [:] },
        productsLoadableStub: Result<[DecodableProduct], Error> = .success([]),
        salesLoadableStub: Result<[DecodableSale], Error> = .success([])
    ) -> RemoteProductSalesLoader {
        return RemoteProductSalesLoader(
            mapper: mapper,
            productsLoader: RemoteProductsLoadableStub(
                stub: productsLoadableStub
            ),
            remoteSalesLoader: RemoteSalesLoadableStub(
                stub: salesLoadableStub
            )
        )
    }
}

struct RemoteProductsLoadableStub: RemoteProductsLoadable {
    let stub: Result<[DecodableProduct], Error>
    func loadProducts() async throws -> [SalesTracker.DecodableProduct] {
        try stub.get()
    }
}

struct RemoteSalesLoadableStub: RemoteSalesLoadable {
    let stub: Result<[DecodableSale], Error>
    func loadSales() async throws -> [SalesTracker.DecodableSale] {
        try stub.get()
    }
}
