//
//  RemoteProductSalesLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

typealias ProductSalesDictionaryMapper = ([DecodableProduct], [DecodableSale]) throws -> [Product: [Sale]]

protocol RemoteSalesLoadable {
    func loadSales() async throws -> [DecodableSale]
}

protocol RemoteProductsLoadable {
    func loadProducts() async throws -> [DecodableProduct]
}

struct RemoteProductSalesLoader {
    let mapper: ProductSalesDictionaryMapper
    let productsLoader: RemoteProductsLoadable
    let remoteSalesLoader: RemoteSalesLoadable
}

extension RemoteProductSalesLoader: ProductSalesLoadable {
    func loadProductsAndSales() async throws -> [Product: [Sale]] {
        async let products = try await productsLoader.loadProducts()
        async let sales = try await remoteSalesLoader.loadSales()
        return try await mapper(products, sales)
    }
}
