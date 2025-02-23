//
//  RemoteProductsLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

typealias RemoteProductsListMapper = ((data: Data, httpResponse: HTTPURLResponse)) throws -> [DecodableProduct]

struct RemoteProductsLoader {
    let httpClient: SalesTrackerHTTPClient
    let url: URL
    let mapper: RemoteProductsListMapper
    
    func loadProducts() async throws -> [DecodableProduct] {
        try await mapper(httpClient.get(from: url))
    }
}
