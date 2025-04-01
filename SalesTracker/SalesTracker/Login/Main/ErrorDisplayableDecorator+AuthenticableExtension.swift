//
//  ErrorDisplayableDecorator+AuthenticableExtension.swift
//  SalesTracker
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation

// MARK: Authenticable

extension ErrorDisplayableDecorator: Authenticable where ObjectType == Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        try await perform {
            try await decoratee.authenticate(with: credentials)
        }
    }
}
