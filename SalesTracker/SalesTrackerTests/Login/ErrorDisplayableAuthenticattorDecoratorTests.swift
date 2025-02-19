//
//  ErrorDisplayableAuthenticattorDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Testing
@testable import SalesTracker

struct ErrorDisplayableAuthenticattorDecorator {
    
}

extension ErrorDisplayableAuthenticattorDecorator: Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        throw LoginError.authentication
    }
}

struct ErrorDisplayableAuthenticattorDecoratorTests {
    @Test func throws_on_authentication_error() async throws {
        let sut = makeSUT()
        
        await #expect(throws: LoginError.authentication) {
            try await sut.authenticate(with: anyLoginCredentials)
        }
    }
    
    @Test func forwards_result_on_authentication_success() async throws {
        
    }
    @Test func dispatches_error_on_authentication_error() async throws {
    }

    @Test func does_not_dispatch_error_on_authentication_success() async throws {
        
    }
}

extension ErrorDisplayableAuthenticattorDecoratorTests {
    func makeSUT() -> Authenticable {
        ErrorDisplayableAuthenticattorDecorator()
    }
}
