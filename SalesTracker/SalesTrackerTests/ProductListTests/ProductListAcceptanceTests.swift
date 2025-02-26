//
//  ProductListAcceptanceTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 26/2/25.
//

import Testing
import Foundation

@testable import SalesTracker

struct ProductListAcceptanceTests {

    @Test func does_not_update_on_load_error() async throws {
        let sut = makeSUT(stub: .failure(anyError))
        await #expect(sut.productSalesViews.count == 0)

        await #expect(throws: anyError, performing: {
            _ = try await sut.onRefresh()
        })
        
        await #expect(sut.productSalesViews.count == 0)
    }
}

extension ProductListAcceptanceTests {
    func makeSUT(stub: Result<[Product : [Sale]], Error>) -> ProductListView {
        try! ProductsListComposer.compose(
            with: ProductSalesLoadableStub(stub: stub),
            productSelection: { _, _ in  }
        )
    }
}

struct ProductSalesLoadableStub: ProductSalesLoadable {
    let stub: Result<[Product : [Sale]], Error>
    func loadProductsAndSales() async throws -> [Product : [Sale]] {
        try stub.get()
    }
}

var someSale: Sale {
    Sale(date: .now, amount: 12.3, currencyCode: "USD")
}

var someProduct: Product {
    Product(id: UUID(), name: "aname")
}
