//
//  SalesTrackerHTTPClient.swift
//  SalesTracker
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation

protocol SalesTrackerHTTPClient {
    func post<T: Encodable>(
        url: URL,
        body: T
    ) async throws -> (httpResponse: HTTPURLResponse, data: Data)
}

enum HTTPError: Error {
    case notFound
}
