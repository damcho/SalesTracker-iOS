//
//  TokenStoreAuthenticableDecorator.swift
//  SalesTracker
//
//  Created by Damian Modernell on 20/2/25.
//

import Foundation

protocol TokenLoadable {
    func loadAccessToken() throws -> String
}

protocol TokenStore {
    func store(_ token: String) throws
}

struct TokenStoreAuthenticableDecorator {
    let decoratee: Authenticable
    let store: TokenStore
}

// MARK: Authenticable

extension TokenStoreAuthenticableDecorator: Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        let result = try await decoratee.authenticate(with: credentials)
        try store.store(result.authToken)
        return result
    }
}
