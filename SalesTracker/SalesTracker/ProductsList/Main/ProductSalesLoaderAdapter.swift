//
//  ProductSalesLoaderAdapter.swift
//  SalesTracker
//
//  Created by Damian Modernell on 26/2/25.
//

import Foundation

protocol ProductSalesLoadable {
    func loadProductsAndSales() async throws -> [Product: [Sale]]
}

struct ProductSalesLoaderAdapter {
    let productSalesLoader: ProductSalesLoadable
    let onSelectedProduct: (Product, [Sale]) -> Void
    
    func loadProductsAndSales() async throws -> [ProductSalesView] {
        let productSalesDictionary = try await productSalesLoader.loadProductsAndSales()
        return productSalesDictionary.map { product, sales in
            ProductSalesView(
                viewModel: ProductSalesViewModel(
                    productInfo: ProductInfo(
                        product: product,
                        salesCount: sales.count
                    ),
                    selectedProductAction: { product in
                        onSelectedProduct(product, sales)
                    })
            )
        }
    }
}
    
