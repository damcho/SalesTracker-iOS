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
    @Test func creates_product_sales_views_on_successful_load() async throws {
        let sut = makeSUT(stub: .success(productInfo.raw))

        let productSalesViews = try await sut.onRefresh()

        assertProductSalesViewModels(
            for: productSalesViews,
            expectedResult: [productInfo.info]
        )
    }
}

extension ProductListAcceptanceTests {
    func assertProductSalesViewModels(for views: [ProductSalesView], expectedResult: [ProductInfo]) {
        let productsInfoArray = views.map { view in
            view.viewModel.productInfo
        }
        #expect(productsInfoArray == expectedResult)
    }
    
    func makeSUT(stub: Result<[Product : [Sale]], Error>) -> ProductListView {
        ProductsListComposer.compose(
            with: ProductSalesLoadableStub(stub: stub),
            productSelection: { _, _ in  },
            authErrorHandler: {}
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
    Product(id: UUID(uuidString: "7019D8A7-0B35-4057-B7F9-8C5471961ED0")!, name: "aname")
}

var productInfo: (info: ProductInfo, raw: [Product: [Sale]]) {
    (
        ProductInfo(
            product: someProduct,
            salesCount: 1
        ),
        [someProduct: [someSale]]
    )
}
