//
//  RemoteAuthenticatorHandlerTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Testing
import Foundation

@testable import SalesTracker

struct RemoteAuthenticatorHandlerTests {

    @Test func throws_connectivity_error_on_http_error() async throws {
        await #expect(throws: LoginError.connectivity, performing: {
            let sut = makeSUT(httpStub: .failure(HTTPError.notFound))
            _ = try await sut.authenticate(with: anyLoginCredentials)
        })
    }
    
    @Test func throws_on_mapping_error() async throws {
        await #expect(throws: LoginError.other, performing: {
            let sut = makeSUT(
                httpStub: .success((successfulHTTPResponse, validToken.data)),
                mapper: {_, _ in
                    throw LoginError.other
                }
            )
            _ = try await sut.authenticate(with: anyLoginCredentials)
        })
    }
    
    @Test func maps_on_http_successful_response() async throws {
        var mapResponseCount = 0
        let sut = makeSUT(
            httpStub: .success((successfulHTTPResponse, validToken.data)),
            mapper: {_, _ in
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
        mapper: @escaping AuthMapper = {_, _ in
            anyAuthenticationResult
        }
    ) -> RemoteAuthenticatorHandler {
        RemoteAuthenticatorHandler(
            httpClient: HTTPClientStub(stub: httpStub),
            url: anyURL,
            mapper: mapper
        )
    }
}

typealias HTTPResult =  Result<(httpResponse: HTTPURLResponse, data: Data), Error>
struct HTTPClientStub: SalesTrackerHTTPClient {
    let stub: HTTPResult
    func post<T>(url: URL, body: T) async throws -> (httpResponse: HTTPURLResponse, data: Data) where T : Encodable {
        try stub.get()
    }
}

var anyURL: URL {
    URL(string: "https://example.com")!
}
