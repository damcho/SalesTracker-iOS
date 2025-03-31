//
//  ProductSalesViewModelTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation
@testable import SalesTracker
import Testing

struct ProductSalesViewModelTests {
    @Test
    func executes_action_on_tap() async throws {
        var selectedProductCallCount = 0
        let sut = makeSUT { _ in
            selectedProductCallCount += 1
        }

        sut.didSelectProduct()

        #expect(selectedProductCallCount == 1)
    }

    @Test
    func displays_product_name() async throws {
        let aProduct = someProduct
        let sut = makeSUT(product: aProduct)

        #expect(sut.productName == aProduct.name)
    }

    @Test
    func displays_product_sales_count() async throws {
        let aProduct = someProduct
        let sut = makeSUT(product: aProduct)

        #expect(sut.salesAmount == ProductSalesViewModel.ProductSalesRepresentation.sales(aProduct.sales.count).value)
    }
}

extension ProductSalesViewModelTests {
    func makeSUT(
        product: Product = someProduct,
        didSelectProductAction: @escaping SelectedProductAction = { _ in }
    )
        -> ProductSalesViewModel
    {
        ProductSalesViewModel(
            product: product,
            selectedProductAction: didSelectProductAction
        )
    }
}
