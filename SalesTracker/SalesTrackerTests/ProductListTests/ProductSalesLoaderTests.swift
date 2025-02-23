//
//  ProductSalesLoaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 23/2/25.
//

import Testing
@testable import SalesTracker

typealias ProductSalesDictionaryMapper = ([DecodableProduct], [DecodableSale]) throws -> [Product: [Sale]]

protocol RemoteSalesLoadable {
    func loadSales() async throws -> [DecodableSale]
}

protocol RemoteProductsLoadable {
    func loadProducts() async throws -> [DecodableProduct]
}

struct ProductSalesLoader {
    let mapper: ProductSalesDictionaryMapper
    let productsLoader: RemoteProductsLoadable
    let remoteSalesLoader: RemoteSalesLoadable

    func loadProductsAndSales() async throws -> [Product: [Sale]] {
        let products = try await productsLoader.loadProducts()
        let sales = try await remoteSalesLoader.loadSales()
        return [:]
    }
}

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

}

extension ProductSalesLoaderTests {
    func makeSUT(
        mapper: @escaping ProductSalesDictionaryMapper = {_, _ in [:] },
        productsLoadableStub: Result<[DecodableProduct], Error> = .success([]),
        salesLoadableStub: Result<[DecodableSale], Error> = .success([])
    ) -> ProductSalesLoader {
        return ProductSalesLoader(
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
