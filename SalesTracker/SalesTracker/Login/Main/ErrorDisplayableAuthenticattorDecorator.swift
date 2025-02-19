//
//  ErrorDisplayableAuthenticattorDecorator.swift
//  SalesTracker
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation

protocol ErrorDisplayable {
    func display(_ error: Error)
}

struct ErrorDisplayableAuthenticattorDecorator {
    let decoratee: Authenticable
    let errorDisplayable: ErrorDisplayable
}

extension ErrorDisplayableAuthenticattorDecorator: Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        do {
            return try await decoratee.authenticate(with: credentials)
        } catch {
            errorDisplayable.display(error)
            throw error
        }
    }
}
