//
//  ErrorDisplayableAuthenticattorDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation
@testable import SalesTracker
import Testing

struct ErrorDisplayableAuthenticattorDecoratorTests {
    @Test
    func throws_on_authentication_error() async throws {
        let (sut, _) = makeSUT(decorateeStub: .failure(authError))

        await #expect(throws: authError) {
            try await sut.authenticate(with: anyLoginCredentials)
        }
    }

    @Test
    func forwards_result_on_authentication_success() async throws {
        let (sut, _) = makeSUT(decorateeStub: .success(anyAuthenticationResult))

        let result = try await sut.authenticate(with: anyLoginCredentials)

        #expect(result == anyAuthenticationResult)
    }

    @MainActor
    @Test
    func dispatches_error_on_authentication_error() async throws {
        let (sut, errorDisplayableSpy) = makeSUT(decorateeStub: .failure(authError))

        await #expect(throws: authError) {
            _ = try await sut.authenticate(with: anyLoginCredentials)
        }

        #expect(errorDisplayableSpy.errorDisplayMessages == [.hidesError, .displayedError])
    }

    @Test
    func does_not_dispatch_error_on_authentication_success() async throws {
        let (sut, errorDisplayableSpy) = makeSUT(decorateeStub: .success(anyAuthenticationResult))

        _ = try await sut.authenticate(with: anyLoginCredentials)

        #expect(errorDisplayableSpy.errorDisplayMessages == [])
    }

    @MainActor
    @Test
    func displays_error_on_main_thread() async throws {
        let (sut, errorDisplayableSpy) = makeSUT(decorateeStub: .failure(authError))

        let authTask = performActionInBackgroundThread {
            await #expect(throws: authError) {
                _ = try await sut.authenticate(with: anyLoginCredentials)
            }
        }

        try await authTask.value

        #expect(errorDisplayableSpy.isMainThread)
    }

    @MainActor
    @Test
    func hides_error_on_authentication_started() async throws {
        let (sut, errorDisplayableSpy) = makeSUT(decorateeStub: .success(anyAuthenticationResult))

        _ = try await sut.authenticate(with: anyLoginCredentials)

        #expect(errorDisplayableSpy.errorDisplayMessages == [.hidesError])
    }
}

extension ErrorDisplayableAuthenticattorDecoratorTests {
    func makeSUT(
        decorateeStub: Result<AuthenticationResult, Error>
    )
        -> (Authenticable, ErrorDisplayableSpy)
    {
        let errorDisplayableSpy = ErrorDisplayableSpy()
        let sut = LoginScreenComposer.composeErrorDisplayable(
            decoratee: AuthenticableStub(stub: decorateeStub),
            with: errorDisplayableSpy
        )
        return (sut, errorDisplayableSpy)
    }
}
