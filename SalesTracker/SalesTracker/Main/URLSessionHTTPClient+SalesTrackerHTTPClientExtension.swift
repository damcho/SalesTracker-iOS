//
//  URLSessionHTTPClient+SalesTrackerHTTPClientExtension.swift
//  SalesTracker
//
//  Created by Damian Modernell on 20/2/25.
//

import Foundation

extension URLSessionHTTPClient: SalesTrackerHTTPClient {
    func get(from url: URL, headers: [HTTPHeader]) async throws -> (data: Data, httpResponse: HTTPURLResponse) {
        let result = await withCheckedContinuation { continuation in
            _ = get(from: url, headers: headers, completion: { result in
                continuation.resume(returning: result)
            })
        }
        return try result.get()
    }

    func post(
        url: URL,
        body: some Encodable,
        headers: [HTTPHeader]
    ) async throws
        -> (data: Data, httpResponse: HTTPURLResponse)
    {
        let result = await withCheckedContinuation { continuation in
            _ = post(url, body, headers: headers) { result in
                continuation.resume(returning: result)
            }
        }
        return try result.get()
    }
}
