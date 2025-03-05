//
//  AuthenticableStub.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 5/3/25.
//

import Foundation
@testable import SalesTracker

struct AuthenticableStub: Authenticable {
    let stub: Result<AuthenticationResult, Error>
    func authenticate(with _: LoginCredentials) async throws -> AuthenticationResult {
        try stub.get()
    }
}
