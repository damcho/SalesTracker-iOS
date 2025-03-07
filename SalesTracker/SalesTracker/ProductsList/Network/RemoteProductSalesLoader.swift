//
//  RemoteProductSalesLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

struct ProductsSalesInfo: Equatable {
    let productsSalesMap: [Product: [Sale]]
    let currencyConverter: CurrencyConverter
}

typealias ProductSalesDictionaryMapper = ([DecodableProduct], [DecodableSale]) throws -> [Product: [Sale]]

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
    let mapper: ProductSalesDictionaryMapper
    let productsLoader: RemoteProductsLoadable
    let remoteSalesLoader: RemoteSalesLoadable
    let currencyRatesLoader: RemoteCurrencyRatesLoadable
}

// MARK: ProductSalesLoadable

extension RemoteProductSalesLoader: ProductSalesLoadable {
    func loadProductsAndSales() async throws -> ProductsSalesInfo {
        async let products = try await productsLoader.loadProducts()
        async let sales = try await remoteSalesLoader.loadSales()
        async let currencyconversions = try await currencyRatesLoader.loadCurrencyRates()

        return try await ProductsSalesInfo(
            productsSalesMap: mapper(products, sales),
            currencyConverter: currencyconversions
        )
    }
}
