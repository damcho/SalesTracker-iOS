//
//  RemoteAuthenticatorHandlerTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation
import Testing

@testable import SalesTracker

struct RemoteAuthenticatorHandlerTests {
    @Test
    func throws_connectivity_error_on_http_error() async throws {
        await #expect(throws: LoginError.connectivity, performing: {
            let sut = makeSUT(httpStub: .failure(HTTPError.notFound))
            _ = try await sut.authenticate(with: anyLoginCredentials)
        })
    }

    @Test
    func throws_on_mapping_error() async throws {
        await #expect(throws: LoginError.connectivity, performing: {
            let sut = makeSUT(
                httpStub: .success((validToken.data, successfulHTTPResponse)),
                mapper: { _, _ in
                    throw HTTPError.other
                }
            )
            _ = try await sut.authenticate(with: anyLoginCredentials)
        })
    }

    @Test
    func maps_on_http_successful_response() async throws {
        var mapResponseCount = 0
        let sut = makeSUT(
            httpStub: .success((validToken.data, successfulHTTPResponse)),
            mapper: { _, _ in
                mapResponseCount += 1
                return anyAuthenticationResult
            }
        )

        _ = try await sut.authenticate(with: anyLoginCredentials)
        #expect(mapResponseCount == 1)
    }
}

extension RemoteAuthenticatorHandlerTests {
    func makeSUT(
        httpStub: HTTPResult,
        mapper: @escaping AuthMapper = { _, _ in
            anyAuthenticationResult
        }
    )
        -> RemoteAuthenticatorHandler
    {
        RemoteAuthenticatorHandler(
            httpClient: HTTPClientStub(stub: httpStub),
            url: anyURL,
            mapper: mapper
        )
    }
}

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
