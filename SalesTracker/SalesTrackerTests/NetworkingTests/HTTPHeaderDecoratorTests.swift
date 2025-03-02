//
//  HTTPHeaderDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 24/2/25.
//

import Foundation
import Testing

@testable import SalesTracker

struct HTTPHeaderDecoratorTests {
    @Test
    func throws_on_http_call_failure() async throws {
        let (sut, _) = makeSUT(stub: .failure(HTTPError.notFound))

        await #expect(throws: HTTPError.notFound, performing: {
            try await sut.get(from: anyURL)
        })

        await #expect(throws: HTTPError.notFound, performing: {
            try await sut.post(url: anyURL, body: "some body")
        })
    }

    @Test
    func returns_result_on_successful_response() async throws {
        let (sut, _) = makeSUT(stub: .success((anyData, successfulHTTPResponse)))

        #expect(try await sut.get(from: anyURL) == (data: anyData, httpResponse: successfulHTTPResponse))
        #expect(try await sut.post(url: anyURL, body: "some body") == (anyData, successfulHTTPResponse))
    }

    @Test
    func decorates_post_request_with_headers() async throws {
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

    @Test
    func decorates_get_request_with_headers() async throws {
        let newHeader = HTTPHeader(
            key: "new-header-key",
            value: "new-header-value"
        )
        let (sut, decorateeSpy) = makeSUT(
            stub: .success((anyData, successfulHTTPResponse)),
            addedHeaders: [newHeader]
        )

        _ = try await sut.get(
            from: anyURL,
            headers: [anHTTPHeader]
        )

        #expect(decorateeSpy.httpclientHeaders == [anHTTPHeader, newHeader])
    }
}

extension HTTPHeaderDecoratorTests {
    func makeSUT(
        stub: HTTPResult,
        addedHeaders: [HTTPHeader] = []
    )
        -> (HTTPHeaderDecorator, HTTPClientStub)
    {
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
