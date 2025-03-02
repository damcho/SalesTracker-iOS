//
//  SalesTrackerHTTPClient.swift
//  SalesTracker
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation

struct HTTPHeader: Equatable {
    let key: String
    let value: String
}

extension HTTPHeader {
    static func authorization(accessToken: String) -> HTTPHeader {
        HTTPHeader(key: "Authorization", value: accessToken)
    }
}

protocol SalesTrackerHTTPClient {
    func post<T: Encodable>(
        url: URL,
        body: T,
        headers: [HTTPHeader]
    ) async throws -> (data: Data, httpResponse: HTTPURLResponse)

    func get(
        from url: URL,
        headers: [HTTPHeader]
    ) async throws -> (data: Data, httpResponse: HTTPURLResponse)
}

extension SalesTrackerHTTPClient {
    func get(
        from url: URL
    ) async throws
        -> (data: Data, httpResponse: HTTPURLResponse)
    {
        try await get(from: url, headers: [])
    }

    func post(
        url: URL,
        body: some Encodable
    ) async throws
        -> (data: Data, httpResponse: HTTPURLResponse)
    {
        try await post(url: url, body: body, headers: [])
    }
}

enum HTTPError: Error {
    case notFound
    case other
}
