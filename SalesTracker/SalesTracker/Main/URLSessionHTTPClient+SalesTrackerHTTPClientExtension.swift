//
//  URLSessionHTTPClient+SalesTrackerHTTPClientExtension.swift
//  SalesTracker
//
//  Created by Damian Modernell on 20/2/25.
//

import Foundation

extension URLSessionHTTPClient: SalesTrackerHTTPClient {
    func post<T>(url: URL, body: T) async throws -> (data: Data, httpResponse: HTTPURLResponse) where T : Encodable {
        let result = await withCheckedContinuation { continuation in
            _ = post(url, body) { result in
                continuation.resume(returning: result)
            }
        }
        return try result.get()
    }
}
