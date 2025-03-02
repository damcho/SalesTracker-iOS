//
//  RemoteSalesLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

typealias RemoteSalesListMapper = ((data: Data, httpResponse: HTTPURLResponse)) throws -> [DecodableSale]

struct RemoteSalesLoader {
    let httpClient: SalesTrackerHTTPClient
    let url: URL
    let mapper: RemoteSalesListMapper
}

// MARK: RemoteSalesLoadable

extension RemoteSalesLoader: RemoteSalesLoadable {
    func loadSales() async throws -> [SalesTracker.DecodableSale] {
        try await mapper(httpClient.get(from: url))
    }
}
