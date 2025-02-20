//
//  TokenStoreAuthenticableDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 20/2/25.
//

import Testing
@testable import SalesTracker

struct TokenStoreAuthenticableDecoratorTests {
    
    @Test func throws_on_autnetication_failure() async throws {
        let (sut, _) = makeSUT(stub: .failure(authError))
        
        await #expect(throws: authError, performing: {
            _ = try await sut.authenticate(with: anyLoginCredentials)
        })
    }
    
    @Test func forwards_result() async throws {
        let (sut, _) = makeSUT(stub: .success(anyAuthenticationResult))
        
        let result = try await sut.authenticate(with: anyLoginCredentials)
        
        #expect(result == anyAuthenticationResult)
    }
    
    @Test func throws_on_token_store_error() async throws {
        let (sut, tokenStoreSpy)  = makeSUT(
            stub: .success(anyAuthenticationResult)
        )
        tokenStoreSpy.stubResult = .failure(anyError)
        
        await #expect(throws: anyError, performing: {
            let result = try await sut.authenticate(with: anyLoginCredentials)
            #expect(tokenStoreSpy.storeMesages == [result.authToken])
        })
    }
    
    @Test func stores_token_on_authentication_success() async throws {
        let (sut, tokenStoreSpy)  = makeSUT(
            stub: .success(anyAuthenticationResult)
        )
        tokenStoreSpy.stubResult = .success(())

        let result = try await sut.authenticate(with: anyLoginCredentials)
        
        #expect(tokenStoreSpy.storeMesages == [result.authToken])
        #expect(result == anyAuthenticationResult)
    }
}

extension TokenStoreAuthenticableDecoratorTests {
    func makeSUT(
        stub: Result<AuthenticationResult, Error>
    ) -> (Authenticable, TokenStoreSpy) {
        let tokenStoreSpy = TokenStoreSpy()
        return (
            TokenStoreAuthenticableDecorator(
                decoratee: AuthenticableStub(stub: stub),
                store: tokenStoreSpy
            ),
            tokenStoreSpy
        )
    }
}

final class TokenStoreSpy: TokenStore {
    var stubResult: Result<Void, Error>?
    var storeMesages: [String] = []
    func store(_ token: String) throws {
        storeMesages.append(token)
        try stubResult?.get()
    }
}
