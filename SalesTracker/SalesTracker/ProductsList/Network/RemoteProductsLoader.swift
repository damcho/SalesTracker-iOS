//
//  RemoteProductsLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

typealias RemoteProductsLoader = RemoteGetLoader<[DecodableProduct]>

// MARK: - RemoteGetLoader + RemoteProductsLoadable

extension RemoteGetLoader: RemoteProductsLoadable where ObjectType == [DecodableProduct] {
    func loadProducts() async throws -> [DecodableProduct] {
        try await performGetRequest()
    }
}
