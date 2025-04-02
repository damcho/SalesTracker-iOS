//
//  RemoteProductSalesLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

typealias ProductsMapper = ([DecodableProduct], [DecodableSale], CurrencyConverter) throws -> [Product]

protocol RemoteSalesLoadable {
    func loadSales() async throws -> [DecodableSale]
}

protocol RemoteProductsLoadable {
    func loadProducts() async throws -> [DecodableProduct]
}

protocol RemoteCurrencyRatesLoadable {
    func loadCurrencyRates() async throws -> CurrencyConverter
}

struct RemoteProductSalesLoader {
    let mapper: ProductsMapper
    let productsLoader: RemoteProductsLoadable
    let remoteSalesLoader: RemoteSalesLoadable
    let currencyRatesLoader: RemoteCurrencyRatesLoadable
}

// MARK: ProductSalesLoadable

extension RemoteProductSalesLoader: ProductSalesLoadable {
    func loadProductsAndSales() async throws -> [Product] {
        async let products = try await productsLoader.loadProducts()
        async let sales = try await remoteSalesLoader.loadSales()
        async let currencyConverter = try await currencyRatesLoader.loadCurrencyRates()

        return try await mapper(products, sales, currencyConverter)
    }
}
