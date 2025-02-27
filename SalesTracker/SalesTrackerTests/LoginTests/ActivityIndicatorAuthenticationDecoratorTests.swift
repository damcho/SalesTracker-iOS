//
//  ActivityIndicatorAuthenticationDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 16/2/25.
//

import Testing
import Foundation

@testable import SalesTracker

struct ActivityIndicatorAuthenticationDecoratorTests {
    
    @Test func throws_on_authentication_failure() async throws {
        let (sut, _) = makeSUT(
            decorateeStub: .failure(authError)
        )
        
        await #expect(throws: authError) {
            try await sut.authenticate(with: anyLoginCredentials)
        }
    }
    
    @MainActor
    @Test func displays_and_hides_activity_indicator_on_authentication_success() async throws {
        let (sut, activityIndicatorDisplayableSpy) = makeSUT()

        _ = try await sut.authenticate(with: anyLoginCredentials)

        #expect(activityIndicatorDisplayableSpy.activityIndicatorMessages == [true , false])
    }
    
    @MainActor
    @Test func displays_and_hides_activity_indicator_on_authentication_failure() async throws {
        let (sut, activityIndicatorDisplayableSpy) = makeSUT(
            decorateeStub: .failure(authError)
        )
        
        await #expect(throws: authError) {
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
    
    @MainActor
    @Test func displays_activity_indicator_in_main_thread() async throws {
        let (sut, spy) = makeSUT(
            decorateeStub: .success(anyAuthenticationResult)
        )
      
        let task = performActionInBackgroundThread {
            _ = try await sut.authenticate(with: anyLoginCredentials)
        }
        try await task.value

        #expect(spy.isMainThread)
    }
}

extension ActivityIndicatorAuthenticationDecoratorTests {
    func makeSUT(
        decorateeStub: Result<AuthenticationResult, Error> = .success(anyAuthenticationResult)
    ) -> (Authenticable, activityIndicatorDisplayableSpy) {
        let stub = AuthenticableStub(stub: decorateeStub)
        let activityIndicatorSpy = activityIndicatorDisplayableSpy()
        return (
            LoginScreenComposer.composeActivityIndicator(
                for: stub,
                activityIndicatorDisplayable: activityIndicatorSpy
            ),
            activityIndicatorSpy
        )
    }
}

final class activityIndicatorDisplayableSpy: ActivityIndicatorDisplayable {
    var activityIndicatorMessages: [Bool] = []
    var isMainThread = false
    func displayActivityIndicator() {
        activityIndicatorMessages.append(true)
        isMainThread = Thread.isMainThread
    }
    
    func hideActivityIndicator() {
        activityIndicatorMessages.append(false)
        isMainThread = Thread.isMainThread
    }
}

struct AuthenticableStub: Authenticable {
    let stub: Result<AuthenticationResult, Error>
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        try stub.get()
    }
}
