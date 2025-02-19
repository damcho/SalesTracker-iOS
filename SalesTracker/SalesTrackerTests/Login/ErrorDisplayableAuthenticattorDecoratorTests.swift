//
//  ErrorDisplayableAuthenticattorDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Testing
@testable import SalesTracker

struct ErrorDisplayableAuthenticattorDecoratorTests {
    @Test func throws_on_authentication_error() async throws {
        let (sut, _) = makeSUT(decorateeStub: .failure(LoginError.authentication))
        
        await #expect(throws: LoginError.authentication) {
            try await sut.authenticate(with: anyLoginCredentials)
        }
    }
    
    @Test func forwards_result_on_authentication_success() async throws {
        let (sut, _) = makeSUT(decorateeStub: .success(anyAuthenticationResult))
        
        let result = try await sut.authenticate(with: anyLoginCredentials)

        #expect(result == anyAuthenticationResult)
    }
    
    @Test func dispatches_error_on_authentication_error() async throws {
        let (sut, errorDisplayableSpy) = makeSUT(decorateeStub: .failure(LoginError.authentication))

        await #expect(throws: LoginError.authentication) {
            _ = try await sut.authenticate(with: anyLoginCredentials)
        }
        
        #expect(errorDisplayableSpy.errorDisplayMessages == [LoginError.authentication])
    }

    @Test func does_not_dispatch_error_on_authentication_success() async throws {
        let (sut, errorDisplayableSpy) = makeSUT(decorateeStub: .success(anyAuthenticationResult))
        
        _ = try await sut.authenticate(with: anyLoginCredentials)

        #expect(errorDisplayableSpy.errorDisplayMessages == [])
    }
}

extension ErrorDisplayableAuthenticattorDecoratorTests {
    func makeSUT(
        decorateeStub: Result<AuthenticationResult, Error>
    ) -> (Authenticable, ErrorDisplayableSpy) {
        let errorDisplayableSpy = ErrorDisplayableSpy()
        let sut = ErrorDisplayableAuthenticattorDecorator(
            decoratee: AuthenticableStub(
                stub: decorateeStub
            ),
            errorDisplayable: errorDisplayableSpy
        )
        return (sut, errorDisplayableSpy)
    }
}

final class ErrorDisplayableSpy: ErrorDisplayable {
    var errorDisplayMessages: [LoginError?] = []
    func display(_ error: any Error) {
        errorDisplayMessages.append(error as? LoginError)
    }
}
