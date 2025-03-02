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
        return productSalesInfo.productsSalesMap.map { product, sales in
            ProductSalesView(
                viewModel: ProductSalesViewModel(
                    productInfo: ProductInfo(
                        product: product,
                        salesCount: sales.count
                    ),
                    selectedProductAction: { product in
                        onSelectedProduct(product, sales, productSalesInfo.currencyConverter)
                    }
                )
            )
        }.sorted(by: productsOrder)
    }
}
