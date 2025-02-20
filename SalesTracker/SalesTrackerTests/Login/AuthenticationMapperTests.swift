//
//  AuthenticationMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Testing
import Foundation

@testable import SalesTracker

struct AuthenticationMapperTests {

    @Test func throws_authentication_error_on_401_http_response() async throws {
        #expect(throws: invalidCredentialsAuthError.error, performing: {
            _ = try AuthenticationMapper.map(invalidAuthHTTPResponse, invalidCredentialsAuthError.http)
        })
    }
    
    @Test func throws_connectivity_error_on_http_response_error() async throws {
        #expect(throws: LoginError.connectivity, performing: {
            _ = try AuthenticationMapper.map(notFoundHTTPResponse, Data())
        })
    }
    
    @Test func throws_decoding_error_on_invalid_data() async throws {
        #expect(throws: LoginError.connectivity, performing: {
            _ = try AuthenticationMapper.map(notFoundHTTPResponse, invalidData)
        })
    }
    
    @Test func returns_token_on_successful_200_response() async throws {
        #expect(try AuthenticationMapper.map(successfulHTTPResponse, validToken.data) == AuthenticationResult(authToken: validToken.string))
    }
}

var invalidAuthHTTPResponse: HTTPURLResponse {
    HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 401,
        httpVersion: nil,
        headerFields: nil
    )!
}

var successfulHTTPResponse: HTTPURLResponse {
    HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!
}

var notFoundHTTPResponse: HTTPURLResponse {
    HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 400,
        httpVersion: nil,
        headerFields: nil
    )!
}

var invalidCredentialsAuthError: (error: LoginError, http: Data) {
    (
        LoginError.authentication("Invalid credentials"),
        #"{"message": "Invalid credentials"}"#.data(using: .utf8)!
    )
}

var invalidData: Data {
    "Invalid JSON".data(using: .utf8)!
}

var validToken: (data: Data, string: String) {
    (#"{"access_token": "aToken"}"#.data(using: .utf8)!, "aToken")
}
