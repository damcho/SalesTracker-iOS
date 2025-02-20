//
//  AuthenticationMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Testing
import Foundation

@testable import SalesTracker

struct DecodableHTTPErrorMessage: Decodable {
    let message: String
}

enum AuthenticationMapper {
    static let unauthorized = 401
    static let success = 200
    static func map(_ response: HTTPURLResponse, _ data: Data) throws -> AuthenticationResult {
        switch response.statusCode {
        case unauthorized:
            let errorData = try JSONDecoder().decode(DecodableHTTPErrorMessage.self, from: data)

            throw LoginError.authentication(errorData.message)
        case 400, 402..<499:
            throw LoginError.connectivity
        case success: return AuthenticationResult()

        default:
            throw LoginError.other
        }
    }
}

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
        
    }
    
    @Test func returns_token_on_successful_200_response() async throws {
        
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
