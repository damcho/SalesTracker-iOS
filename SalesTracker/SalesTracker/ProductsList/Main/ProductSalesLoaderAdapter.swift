//
//  ProductSalesLoaderAdapter.swift
//  SalesTracker
//
//  Created by Damian Modernell on 26/2/25.
//

import Foundation

protocol ProductSalesLoadable {
    func loadProductsAndSales() async throws -> [Product]
}

struct ProductSalesLoaderAdapter {
    let productSalesLoader: ProductSalesLoadable
    let onSelectedProduct: ProductSelectionHandler
    let productsOrder: (ProductSalesView, ProductSalesView) -> Bool

    func loadProductsAndSales() async throws -> [ProductSalesView] {
        let products = try await productSalesLoader.loadProductsAndSales()
        return products.map { product in
            ProductSalesView(
                viewModel: ProductSalesViewModel(
                    product: product,
                    selectedProductAction: { product in
                        onSelectedProduct(product)
                    }
                )
            )
        }.sorted(by: productsOrder)
    }
}
