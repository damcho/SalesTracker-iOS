//
//  ErrorDisplayableAuthenticattorDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Testing
@testable import SalesTracker

struct ErrorDisplayableAuthenticattorDecorator {
    let decoratee: Authenticable
}

extension ErrorDisplayableAuthenticattorDecorator: Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        try await decoratee.authenticate(with: credentials)
    }
}

struct ErrorDisplayableAuthenticattorDecoratorTests {
    @Test func throws_on_authentication_error() async throws {
        let sut = makeSUT(decorateeStub: .failure(LoginError.authentication))
        
        await #expect(throws: LoginError.authentication) {
            try await sut.authenticate(with: anyLoginCredentials)
        }
    }
    
    @Test func forwards_result_on_authentication_success() async throws {
        let sut = makeSUT(decorateeStub: .success(anyAuthenticationResult))
        
        let result = try await sut.authenticate(with: anyLoginCredentials)

        #expect(result == anyAuthenticationResult)
    }
    
    @Test func dispatches_error_on_authentication_error() async throws {
    }

    @Test func does_not_dispatch_error_on_authentication_success() async throws {
        
    }
}

extension ErrorDisplayableAuthenticattorDecoratorTests {
    func makeSUT(decorateeStub: Result<AuthenticationResult, Error>) -> Authenticable {
        ErrorDisplayableAuthenticattorDecorator(
            decoratee: AuthenticableStub(
                stub: decorateeStub
            )
        )
    }
}
