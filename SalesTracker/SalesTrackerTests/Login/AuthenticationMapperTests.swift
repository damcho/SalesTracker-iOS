//
//  AuthenticationMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Testing
import Foundation

@testable import SalesTracker

enum AuthenticationMapper {
    static func map(_ response: HTTPURLResponse, _ data: Data) throws -> AuthenticationResult {
        throw LoginError.authentication
    }
}

struct AuthenticationMapperTests {

    @Test func throws_authentication_error_on_401_http_response() async throws {
        #expect(throws: LoginError.authentication, performing: {
            _ = try AuthenticationMapper.map(invalidAuthHTTPResponse, errorMessageData)
        })
    }
    
    @Test func throws_connectivity_error_on_other_400_response() async throws {
        
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

var errorMessageData: Data {
    #""message": "Invalid credentials""#.data(using: .utf8)!
}
