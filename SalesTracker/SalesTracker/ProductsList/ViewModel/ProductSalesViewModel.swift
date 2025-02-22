//
//  ProductSalesViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation

typealias SelectedProductAction = (UUID) -> Void

struct Sale {
    
}

struct ProductInfo {
    let productId: UUID
    let name: String
    let sales: [Sale]
}

struct ProductSalesViewModel {
    enum ProductSalesRepresentation {
        case sales(Int)
        
        var value: String {
            switch self {
            case .sales(let value):
                "\(value) Sales"
            }
        }
    }
    let productInfo: ProductInfo
    let selectionAction: SelectedProductAction
    var productName: String {
        productInfo.name
    }
    var salesAmount: String {
        ProductSalesRepresentation.sales(productInfo.sales.count).value
    }
    
    init(productInfo: ProductInfo, selectedProductAction: @escaping SelectedProductAction) {
        self.productInfo = productInfo
        self.selectionAction = selectedProductAction
    }
    
    func didSelectProduct() {
        selectionAction(productInfo.productId)
    }
}
