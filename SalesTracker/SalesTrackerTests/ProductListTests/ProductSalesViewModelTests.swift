//
//  ProductSalesViewModelTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 22/2/25.
//

import Testing
import Foundation
@testable import SalesTracker



struct ProductSalesViewModelTests {

    @Test func executes_action_on_tap() async throws {
        var selectedProductCallCount = 0
        let sut = ProductSalesViewModel(
            productInfo: anyProductInfo,
            selectedProductAction: { _ in
                selectedProductCallCount += 1
            }
        )
        
        sut.didSelectProduct()
        
        #expect(selectedProductCallCount == 1)
    }
}

var anyProductInfo: ProductInfo {
    ProductInfo(productId: UUID())
}
