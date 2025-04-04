//
//  Authenticable.swift
//  SalesTracker
//
//  Created by Damian Modernell on 17/2/25.
//

import Foundation

struct AuthenticationResult: Equatable {
    let authToken: String
}

struct LoginCredentials: Equatable {
    let username: String
    let password: String
}

protocol Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult
}

enum LoginError: Error, Equatable {
    case authentication(String)
}

// MARK: LocalizedError

extension LoginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .authentication(message):
            message
        }
    }
}
