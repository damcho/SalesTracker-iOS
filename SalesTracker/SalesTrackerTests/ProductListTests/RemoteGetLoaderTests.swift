//
//  RemoteGetLoaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation
@testable import SalesTracker
import Testing

struct RemoteGetLoaderTests {
    @Test
    func throws_on_load_error() async throws {
        let sut: RemoteGetLoader<String> = makeSUT(httpCLientStub: .failure(anyError))

        await #expect(throws: anyError, performing: {
            try await sut.performGetRequest()
        })
    }

    @Test
    func returns_mapped_products_on_load_success() async throws {
        let sut = makeSUT(
            httpCLientStub: .success((someString.http, successfulHTTPResponse)),
            mapper: { _ in
                someString.domain
            }
        )

        #expect(try await sut.performGetRequest() == someString.domain)
    }
}

var someString: (http: Data, domain: String) {
    (
        "some string".data(using: .utf8)!,
        "some string"
    )
}

extension RemoteGetLoaderTests {
    func makeSUT<String>(
        httpCLientStub: HTTPResult,
        mapper: @escaping Mapper<String> = { _ in throw anyError }
    )
        -> RemoteGetLoader<String>
    {
        RemoteGetLoader(
            httpClient: HTTPClientStub(stub: httpCLientStub),
            url: anyURL,
            mapper: mapper
        )
    }
}
