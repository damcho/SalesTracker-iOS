//
//  ProductSalesViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation

typealias SelectedProductAction = (UUID) -> Void

struct ProductInfo {
    let productId: UUID
}

struct ProductSalesViewModel {
    let productInfo: ProductInfo
    let selectionAction: SelectedProductAction
    var productName: String {
        "procut"
    }
    var salesAmount: String {
        "prod"
    }
    
    init(productInfo: ProductInfo, selectedProductAction: @escaping SelectedProductAction) {
        self.productInfo = productInfo
        self.selectionAction = selectedProductAction
    }
    
    func didSelectProduct() {
        selectionAction(productInfo.productId)
    }
}
