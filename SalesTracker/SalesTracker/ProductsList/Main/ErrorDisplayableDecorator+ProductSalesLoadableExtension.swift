//
//  ErrorDisplayableDecorator+ProductSalesLoadableExtension.swift
//  SalesTracker
//
//  Created by Damian Modernell on 1/4/25.
//

// MARK: ProductSalesLoadable

extension ErrorDisplayableDecorator: ProductSalesLoadable where ObjectType == ProductSalesLoadable {
    func loadProductsAndSales() async throws -> (products: [Product], currencyConverter: CurrencyConverter) {
        try await perform {
            try await decoratee.loadProductsAndSales()
        }
    }
}
