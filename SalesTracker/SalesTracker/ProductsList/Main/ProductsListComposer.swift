//
//  ProductsListComposer.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

typealias productSelectionHandler = (Product, [Sale]) -> Void

enum ProductsListComposer {        
    static func compose(
        with productsLoadable: ProductSalesLoadable,
        productSelection: @escaping productSelectionHandler
    ) throws -> ProductListView {
        let productSalesAdapter = ProductSalesLoaderAdapter(
            productSalesLoader: productsLoadable,
            onSelectedProduct: productSelection
        )
        return ProductListView(
            onRefresh: {
                return try await productSalesAdapter.loadProductsAndSales()
            }
        )
    }
}
