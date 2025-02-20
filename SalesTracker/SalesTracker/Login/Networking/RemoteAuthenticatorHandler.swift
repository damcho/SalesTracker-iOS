//
//  RemoteAuthenticatorHandler.swift
//  SalesTracker
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation

struct EncodableCredentials: Encodable {
    let username: String
    let password: String
}

extension LoginCredentials {
    func toEncodableCredentials() -> EncodableCredentials {
        EncodableCredentials(username: username, password: password)
    }
}

typealias AuthMapper = (HTTPURLResponse, Data) throws -> AuthenticationResult

struct RemoteAuthenticatorHandler {
    let httpClient: SalesTrackerHTTPClient
    let url: URL
    let mapper: AuthMapper
}

extension RemoteAuthenticatorHandler: Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        do {
            let httpResult = try await httpClient.post(
                url: url,
                body: credentials.toEncodableCredentials()
            )
            return try mapper(
                httpResult.httpResponse, httpResult.data
            )
        } catch is HTTPError {
            throw LoginError.connectivity
        }
    }
}
