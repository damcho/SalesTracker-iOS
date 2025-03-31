//
//  ProductSalesViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation

typealias SelectedProductAction = (Product) -> Void

struct ProductSalesViewModel {
    enum ProductSalesRepresentation {
        case sales(Int)

        var value: String {
            switch self {
            case let .sales(value):
                "\(value) Sales"
            }
        }
    }

    let product: Product
    let selectionAction: SelectedProductAction
    var productName: String {
        product.name
    }

    var salesAmount: String {
        ProductSalesRepresentation.sales(product.sales.count).value
    }

    init(product: Product, selectedProductAction: @escaping SelectedProductAction) {
        self.product = product
        self.selectionAction = selectedProductAction
    }

    func didSelectProduct() {
        selectionAction(product)
    }
}
