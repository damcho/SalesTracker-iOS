//
//  HTTPHeaderDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 24/2/25.
//

import Testing
import Foundation

@testable import SalesTracker

struct HTTPHeaderDecorator {
}

extension HTTPHeaderDecorator: SalesTrackerHTTPClient {
    func post<T>(url: URL, body: T) async throws -> (data: Data, httpResponse: HTTPURLResponse) where T : Encodable {
        throw HTTPError.notFound
    }
    
    func get(from url: URL) async throws -> (data: Data, httpResponse: HTTPURLResponse) {
        throw HTTPError.notFound
    }
}

struct HTTPHeaderDecoratorTests {

    @Test func throws_on_http_call_failure() async throws {
        let sut = makeSUT()
        
        await #expect(throws: HTTPError.notFound, performing: {
            try await sut.get(from: anyURL)
        })
        
        await #expect(throws: HTTPError.notFound, performing: {
            try await sut.post(url: anyURL, body: "some body")
        })
    }

}

extension HTTPHeaderDecoratorTests {
    func makeSUT() -> HTTPHeaderDecorator {
        return HTTPHeaderDecorator()
    }
}
