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
        await #expect(throws: HTTPError.notFound, performing: {
            let sut = makeSUT(httpStub: .failure(HTTPError.notFound))
            _ = try await sut.authenticate(with: anyLoginCredentials)
        })
    }

    @Test
    func throws_on_mapping_error() async throws {
        await #expect(throws: HTTPError.notFound, performing: {
            let sut = makeSUT(
                httpStub: .success((validToken.data, successfulHTTPResponse)),
                mapper: { _, _ in
                    throw HTTPError.notFound
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
                return successfulAuthenticationResult
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
            successfulAuthenticationResult
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
