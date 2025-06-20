//
//  TestHelpers.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 20/2/25.
//

import Foundation
@testable import SalesTracker

var anyURL: URL {
    URL(string: "https://example.com")!
}

var serverErrorHTTPResponse: HTTPURLResponse {
    HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 500,
        httpVersion: nil,
        headerFields: nil
    )!
}

var invalidAuthHTTPResponse: HTTPURLResponse {
    HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 401,
        httpVersion: nil,
        headerFields: nil
    )!
}

let successfulHTTPResponse = HTTPURLResponse(
    url: URL(string: "https://example.com")!,
    statusCode: 200,
    httpVersion: nil,
    headerFields: nil
)!

var notFoundHTTPResponse: HTTPURLResponse {
    HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 400,
        httpVersion: nil,
        headerFields: nil
    )!
}

var invalidCredentialsAuthError: (error: SalesTrackerError, http: Data) {
    (
        SalesTrackerError.authentication("Invalid credentials"),
        #"{"message": "Invalid credentials"}"#.data(using: .utf8)!
    )
}

var invalidData: Data {
    "Invalid JSON".data(using: .utf8)!
}

var validToken: (data: Data, string: String) {
    (#"{"access_token": "aToken"}"#.data(using: .utf8)!, "aToken")
}

var authError: SalesTrackerError {
    SalesTrackerError.authentication("")
}

var anyLoginCredentials: LoginCredentials {
    LoginCredentials(username: "aUsername", password: "aPassword")
}

var anyError: NSError {
    NSError(domain: "", code: 0)
}

var successfulAuthenticationResult: AuthenticationResult {
    AuthenticationResult(authToken: "")
}

@discardableResult
func performActionInBackgroundThread(
    _ action: @escaping () async throws -> Void
)
    -> Task<Void, Error>
{
    Task {
        try await action()
    }
}

var anyNSError: Error {
    NSError(domain: "", code: 0)
}

var anyData: Data {
    "data".data(using: .utf8)!
}

func clearKeychainFromArtifacts() {
    let secItemClasses = [
        kSecClassGenericPassword,
        kSecClassInternetPassword,
        kSecClassCertificate,
        kSecClassKey,
        kSecClassIdentity
    ]
    for secItemClass in secItemClasses {
        let dictionary = [kSecClass as String: secItemClass]
        SecItemDelete(dictionary as CFDictionary)
    }
}
