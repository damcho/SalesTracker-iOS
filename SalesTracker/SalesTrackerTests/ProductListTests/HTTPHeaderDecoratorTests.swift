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
        try await decoratee.get(from: url)
    }
}

struct HTTPHeaderDecoratorTests {

    @Test func throws_on_http_call_failure() async throws {
        let (sut, _) = makeSUT(stub: .failure(HTTPError.notFound))
        
        await #expect(throws: HTTPError.notFound, performing: {
            try await sut.get(from: anyURL)
        })
        
        await #expect(throws: HTTPError.notFound, performing: {
            try await sut.post(url: anyURL, body: "some body")
        })
    }
    
    @Test func returns_result_on_successful_response() async throws {
        let (sut, _) = makeSUT(stub: .success((anyData, successfulHTTPResponse)))
      
        #expect(try await sut.get(from: anyURL) == (data: anyData, httpResponse: successfulHTTPResponse))
        #expect(try await sut.post(url: anyURL, body: "some body") == (anyData, successfulHTTPResponse))
    }
    
    @Test func decorates_post_request_with_headers() async throws {
        let newHeader = HTTPHeader(
            key: "new-header-key",
            value: "new-header-value"
        )
        let (sut, decorateeSpy) = makeSUT(
            stub: .success((anyData, successfulHTTPResponse)),
            addedHeaders: [newHeader]
        )

        _ = try await sut.post(
            url: anyURL,
            body: "body",
            headers: [anHTTPHeader]
        )
        
        #expect(decorateeSpy.httpclientHeaders == [anHTTPHeader, newHeader])
    }
}

extension HTTPHeaderDecoratorTests {
    func makeSUT(
        stub: HTTPResult,
        addedHeaders: [HTTPHeader] = []
    ) -> (HTTPHeaderDecorator, HTTPClientStub) {
        let decorateeStub = HTTPClientStub(stub: stub)
        return (
            HTTPHeaderDecorator(
                decoratee: decorateeStub,
                headers: addedHeaders
            ),
            decorateeStub
        )
    }
}

var anHTTPHeader: HTTPHeader {
    HTTPHeader(key: "key", value: "value")
}
