//
//  ActivityIndicatorAuthenticationDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 16/2/25.
//

import Testing
import Foundation

@testable import SalesTracker

struct AuthenticationResult {
    
}

struct LoginCredentials {
    
}

protocol Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult
}

enum LoginError: Error {
    case connectivity
    case authentication
}

struct ActivityIndicatorAuthenticationDecorator {
    let decoratee: Authenticable
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        throw LoginError.authentication
    }
        
}

struct ActivityIndicatorAuthenticationDecoratorTests {
    
    @Test func throws_on_authentication_failure() async throws {
        let (sut, _) = makeSUT(decorateeStub: .failure(anyError))
        
        await #expect(throws: LoginError.authentication) {
            try await sut.authenticate(with: anyLoginCredentials)
        }
    }

    @Test func displays_activity_indicator_on_authentication_started() async throws {

    }
    
    @Test func hides_activity_indicator_on_authentication_failure() async throws {
        
    }
    
    @Test func hides_activity_indicator_on_authentication_success() async throws {
        
    }
    
    @Test func forwards_result_on_authentication_completion() async throws {
        
    }
}

extension ActivityIndicatorAuthenticationDecoratorTests {
    func makeSUT(
        decorateeStub: Result<AuthenticationResult, Error> = .success(AuthenticationResult())
    ) -> (ActivityIndicatorAuthenticationDecorator, AuthenticableStub) {
        let stub = AuthenticableStub(stub: decorateeStub)
        return (
            ActivityIndicatorAuthenticationDecorator(
                decoratee: stub
            ),
            stub
        )
    }
}

struct AuthenticableStub: Authenticable {
    let stub: Result<AuthenticationResult, Error>
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        try stub.get()
    }
}

var anyLoginCredentials: LoginCredentials {
    LoginCredentials()
}

var anyError: Error {
    NSError(domain: "", code: 0)
}
