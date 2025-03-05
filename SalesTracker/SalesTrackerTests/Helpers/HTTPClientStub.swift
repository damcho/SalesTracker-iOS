//
//  HTTPClientStub.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 5/3/25.
//

import Foundation
@testable import SalesTracker

final class HTTPClientStub: SalesTrackerHTTPClient {
    let stub: HTTPResult
    var httpclientHeaders: [HTTPHeader] = []

    init(stub: HTTPResult) {
        self.stub = stub
    }

    func post(
        url _: URL,
        body _: some Encodable,
        headers: [HTTPHeader]
    ) async throws
        -> (data: Data, httpResponse: HTTPURLResponse)
    {
        httpclientHeaders = headers
        return try stub.get()
    }

    func get(from _: URL, headers: [HTTPHeader]) async throws -> (data: Data, httpResponse: HTTPURLResponse) {
        httpclientHeaders = headers
        return try stub.get()
    }
}
