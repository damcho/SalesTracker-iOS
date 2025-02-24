//
//  HTTPHeaderDecorator.swift
//  SalesTracker
//
//  Created by Damian Modernell on 24/2/25.
//

import Foundation

struct HTTPHeaderDecorator {
    let decoratee: SalesTrackerHTTPClient
    let headers: [HTTPHeader]
    
    func addHeaders(to currentHeaders: [HTTPHeader]) -> [HTTPHeader] {
        currentHeaders + headers
    }
}

extension HTTPHeaderDecorator: SalesTrackerHTTPClient {
    func post<T>(url: URL, body: T, headers: [HTTPHeader]) async throws -> (data: Data, httpResponse: HTTPURLResponse) where T : Encodable {
        try await decoratee.post(url: url, body: body, headers: addHeaders(to: headers))
    }
    
    func get(from url: URL, headers: [HTTPHeader]) async throws -> (data: Data, httpResponse: HTTPURLResponse) {
        try await decoratee.get(from: url, headers: addHeaders(to: headers))
    }
}
