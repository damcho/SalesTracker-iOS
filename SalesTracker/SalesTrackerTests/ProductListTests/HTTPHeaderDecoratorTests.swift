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
    let decoratee: SalesTrackerHTTPClient
}

extension HTTPHeaderDecorator: SalesTrackerHTTPClient {
    func post<T>(url: URL, body: T) async throws -> (data: Data, httpResponse: HTTPURLResponse) where T : Encodable {
        try await decoratee.post(url: url, body: body)
    }
    
    func get(from url: URL) async throws -> (data: Data, httpResponse: HTTPURLResponse) {
        try await decoratee.get(from: url)
    }
}

struct HTTPHeaderDecoratorTests {

    @Test func throws_on_http_call_failure() async throws {
        let sut = makeSUT(stub: .failure(HTTPError.notFound))
        
        await #expect(throws: HTTPError.notFound, performing: {
            try await sut.get(from: anyURL)
        })
        
        await #expect(throws: HTTPError.notFound, performing: {
            try await sut.post(url: anyURL, body: "some body")
        })
    }
    
    @Test func returns_result_on_successful_response() async throws {
        let sut = makeSUT(stub: .success((anyData, successfulHTTPResponse)))
      
        #expect(try await sut.get(from: anyURL) == (data: anyData, httpResponse: successfulHTTPResponse))
        #expect(try await sut.post(url: anyURL, body: "some body") == (anyData, successfulHTTPResponse))
    }
}

extension HTTPHeaderDecoratorTests {
    func makeSUT(stub: HTTPResult) -> HTTPHeaderDecorator {
        let decorateeStub = HTTPClientStub(stub: stub)
        return HTTPHeaderDecorator(decoratee: decorateeStub)
    }
}
