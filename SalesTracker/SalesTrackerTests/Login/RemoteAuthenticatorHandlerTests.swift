//
//  RemoteAuthenticatorHandlerTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Testing
@testable import SalesTracker

struct RemoteAuthenticatorHandler {
    
}

extension RemoteAuthenticatorHandler: Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        throw LoginError.connectivity
    }
}

struct RemoteAuthenticatorHandlerTests {

    @Test func throws_connectivity_error_on_http_error() async throws {
        await #expect(throws: LoginError.connectivity, performing: {
            try await RemoteAuthenticatorHandler().authenticate(with: anyLoginCredentials)
        })
    }
    
    @Test func maps_on_http_successful_response() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
