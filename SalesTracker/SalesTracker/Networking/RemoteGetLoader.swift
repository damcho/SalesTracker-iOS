//
//  RemoteGetLoader.swift
//  SalesTracker
//
//  Created by Damian Modernell on 4/3/25.
//

import Foundation

typealias Mapper<ObjectType> = ((data: Data, httpResponse: HTTPURLResponse)) throws -> ObjectType

struct RemoteGetLoader<ObjectType> {
    let httpClient: SalesTrackerHTTPClient
    let url: URL
    let mapper: Mapper<ObjectType>

    func performGetRequest() async throws -> ObjectType {
        try await mapper(httpClient.get(from: url))
    }
}
