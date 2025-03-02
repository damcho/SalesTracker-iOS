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
        let aProduct = anyProductInfo
        let sut = makeSUT(productInfo: aProduct)

        #expect(sut.productName == aProduct.product.name)
    }

    @Test
    func displays_product_sales_count() async throws {
        let aProduct = anyProductInfo
        let sut = makeSUT(productInfo: aProduct)

        #expect(sut.salesAmount == ProductSalesViewModel.ProductSalesRepresentation.sales(aProduct.salesCount).value)
    }
}

extension ProductSalesViewModelTests {
    func makeSUT(
        productInfo: ProductInfo = anyProductInfo,
        didSelectProductAction: @escaping SelectedProductAction = { _ in }
    )
        -> ProductSalesViewModel
    {
        ProductSalesViewModel(
            productInfo: productInfo,
            selectedProductAction: didSelectProductAction
        )
    }
}

var anyProductInfo: ProductInfo {
    let pdoructID = UUID()
    return ProductInfo(
        product: .init(
            id: pdoructID,
            name: "aname"
        ),
        salesCount: 3
    )
}
