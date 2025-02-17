//
//  ActivityIndicatorAuthenticationDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 16/2/25.
//

import Testing
import Foundation

@testable import SalesTracker

struct AuthenticationResult: Equatable {
    
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

protocol ActivityIndicatorDisplayable {
    func displayActivityIndicator()
    func hideActivityIndicator()
}
struct ActivityIndicatorAuthenticationDecorator {
    let decoratee: Authenticable
    let activityIndicatorDisplayable: ActivityIndicatorDisplayable
    
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        activityIndicatorDisplayable.displayActivityIndicator()
        var result: AuthenticationResult!
        do {
            result = try await decoratee.authenticate(with: credentials)
            activityIndicatorDisplayable.hideActivityIndicator()
        } catch {
            activityIndicatorDisplayable.hideActivityIndicator()
            throw error
        }
        return result
    }
}

struct ActivityIndicatorAuthenticationDecoratorTests {
    
    @Test func throws_on_authentication_failure() async throws {
        let (sut, _) = makeSUT(
            decorateeStub: .failure(LoginError.authentication)
        )
        
        await #expect(throws: LoginError.authentication) {
            try await sut.authenticate(with: anyLoginCredentials)
        }
    }

    @Test func displays_and_hides_activity_indicator_on_authentication_success() async throws {
        let (sut, activityIndicatorDisplayableSpy) = makeSUT()

        _ = try await sut.authenticate(with: anyLoginCredentials)

        #expect(activityIndicatorDisplayableSpy.activityIndicatorMessages == [true , false])
    }
    
    @Test func displays_and_hides_activity_indicator_on_authentication_failure() async throws {
        let (sut, activityIndicatorDisplayableSpy) = makeSUT(
            decorateeStub: .failure(LoginError.authentication)
        )
        
        await #expect(throws: LoginError.authentication) {
            try await sut.authenticate(with: anyLoginCredentials)
        }
        
        #expect(activityIndicatorDisplayableSpy.activityIndicatorMessages == [true , false])
    }
    
    @Test func forwards_result_on_authentication_completion() async throws {
        let expectedResult = anyAuthenticationResult
        let (sut, _) = makeSUT(
            decorateeStub: .success(expectedResult)
        )

        let result = try await sut.authenticate(with: anyLoginCredentials)

        #expect(result == expectedResult)
    }
}

extension ActivityIndicatorAuthenticationDecoratorTests {
    func makeSUT(
        decorateeStub: Result<AuthenticationResult, Error> = .success(AuthenticationResult())
    ) -> (ActivityIndicatorAuthenticationDecorator, activityIndicatorDisplayableSpy) {
        let stub = AuthenticableStub(stub: decorateeStub)
        let activityIndicatorSpy = activityIndicatorDisplayableSpy()
        return (
            ActivityIndicatorAuthenticationDecorator(
                decoratee: stub,
                activityIndicatorDisplayable: activityIndicatorSpy
            ),
            activityIndicatorSpy
        )
    }
}

final class activityIndicatorDisplayableSpy: ActivityIndicatorDisplayable {
    var activityIndicatorMessages: [Bool] = []
    func displayActivityIndicator() {
        activityIndicatorMessages.append(true)
    }
    
    func hideActivityIndicator() {
        activityIndicatorMessages.append(false)
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

var anyAuthenticationResult: AuthenticationResult {
    AuthenticationResult()
}
