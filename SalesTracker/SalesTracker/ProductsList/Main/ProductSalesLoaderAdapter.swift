//
//  ProductSalesLoaderAdapter.swift
//  SalesTracker
//
//  Created by Damian Modernell on 26/2/25.
//

import Foundation

protocol ProductSalesLoadable {
    func loadProductsAndSales() async throws -> ProductsSalesInfo
}

struct ProductSalesLoaderAdapter {
    let productSalesLoader: ProductSalesLoadable
    let onSelectedProduct: ProductSelectionHandler
    let productsOrder: (ProductSalesView, ProductSalesView) -> Bool

    func loadProductsAndSales() async throws -> [ProductSalesView] {
        let productSalesInfo = try await productSalesLoader.loadProductsAndSales()
        return productSalesInfo.products.map { product in
            ProductSalesView(
                viewModel: ProductSalesViewModel(
                    productInfo: ProductInfo(
                        product: product,
                        salesCount: product.sales.count
                    ),
                    selectedProductAction: { product in
                        onSelectedProduct(product, productSalesInfo.currencyConverter)
                    }
                )
            )
        }.sorted(by: productsOrder)
    }
}
