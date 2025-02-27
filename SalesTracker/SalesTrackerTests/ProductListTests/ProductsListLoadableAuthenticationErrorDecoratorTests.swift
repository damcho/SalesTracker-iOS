//
//  ProductsListLoadableAuthenticationErrorDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 27/2/25.
//

import Testing
@testable import SalesTracker

struct ProductsListLoadableAuthenticationErrorDecorator {
    
}

extension ProductsListLoadableAuthenticationErrorDecorator: ProductSalesLoadable {
    func loadProductsAndSales() async throws -> [Product : [Sale]] {
        throw anyError
    }
}

struct ProductsListLoadableAuthenticationErrorDecoratorTests {

    @Test func forwards_error_on_loader_error() async throws {
        let sut = makeSUT()
        
        await #expect(throws: anyError, performing: {
            try await sut.loadProductsAndSales()
        })
    }

}

extension ProductsListLoadableAuthenticationErrorDecoratorTests {
    func makeSUT() -> ProductsListLoadableAuthenticationErrorDecorator {
        return ProductsListLoadableAuthenticationErrorDecorator()
    }
}
