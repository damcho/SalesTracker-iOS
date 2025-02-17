//
//  Authenticable.swift
//  SalesTracker
//
//  Created by Damian Modernell on 17/2/25.
//

import Foundation

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
