//
//  TokenStoreAuthenticableDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 20/2/25.
//

import Testing
@testable import SalesTracker

struct TokenStoreAuthenticableDecorator {
    
}

extension TokenStoreAuthenticableDecorator: Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        throw authError
    }
}

struct TokenStoreAuthenticableDecoratorTests {

    @Test func throws_on_autnetication_failure() async throws {
        let sut = makeSUT(stub: .failure(authError))
        
        await #expect(throws: authError, performing: {
            _ = try await sut.authenticate(with: anyLoginCredentials)
        })
    }
    
    @Test func throws_on_token_store_error() async throws {
     
    }
    
    @Test func stores_token_on_authentication_success() async throws {
     
    }
    
    @Test func forwards_result() async throws {
     
    }

}

extension TokenStoreAuthenticableDecoratorTests {
    func makeSUT(stub: Result<AuthenticationResult, Error>) -> Authenticable {
        TokenStoreAuthenticableDecorator()
    }
}
