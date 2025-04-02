//
//  ActivityIndicatorAuthenticationDecorator.swift
//  SalesTracker
//
//  Created by Damian Modernell on 17/2/25.
//

import Foundation

struct ActivityIndicatorAuthenticationDecorator {
    let decoratee: Authenticable
    let activityIndicatorDisplayable: ActivityIndicatorDisplayable
}

// MARK: Authenticable

extension ActivityIndicatorAuthenticationDecorator: Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        await activityIndicatorDisplayable.displayActivityIndicator()
        var result: AuthenticationResult!
        do {
            result = try await decoratee.authenticate(with: credentials)
            await activityIndicatorDisplayable.hideActivityIndicator()
        } catch {
            await activityIndicatorDisplayable.hideActivityIndicator()
            throw error
        }
        return result
    }
}
