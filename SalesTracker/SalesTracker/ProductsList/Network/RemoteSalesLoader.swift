//
//  RemoteSalesLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

typealias RemoteSalesLoader = RemoteGetLoader<[DecodableSale]>

// MARK: - RemoteGetLoader + RemoteSalesLoadable

extension RemoteGetLoader: RemoteSalesLoadable where ObjectType == [DecodableSale] {
    func loadSales() async throws -> [DecodableSale] {
        try await mapper(httpClient.get(from: url))
    }
}
