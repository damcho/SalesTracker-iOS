//
//  AuthenticationMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation
import Testing

@testable import SalesTracker

protocol MapperSpecs {
    func throws_connectivity_error_on_not_found_status_code() async throws
    func throws_decoding_error_on_invalid_data() async throws
    func returns_mapped_data_on_successful_200_status_code() async throws
    func throws_other_error_on_other_http_status_code() async throws
}

struct AuthenticationMapperTests: MapperSpecs {
    @Test
    func throws_authentication_error_on_401_status_code() async throws {
        #expect(throws: invalidCredentialsAuthError.error, performing: {
            _ = try AuthenticationMapper.map(invalidAuthHTTPResponse, invalidCredentialsAuthError.http)
        })
    }

    @Test
    func throws_connectivity_error_on_not_found_status_code() async throws {
        #expect(throws: LoginError.connectivity, performing: {
            _ = try AuthenticationMapper.map(notFoundHTTPResponse, Data())
        })
    }

    @Test
    func throws_decoding_error_on_invalid_data() async throws {
        #expect(throws: DecodingError.self, performing: {
            _ = try AuthenticationMapper.map(successfulHTTPResponse, invalidData)
        })
    }

    @Test
    func returns_mapped_data_on_successful_200_status_code() async throws {
        #expect(
            try AuthenticationMapper
                .map(successfulHTTPResponse, validToken.data) == AuthenticationResult(authToken: validToken.string)
        )
    }

    @Test
    func throws_other_error_on_other_http_status_code() async throws {
        #expect(throws: HTTPError.other, performing: {
            _ = try AuthenticationMapper.map(serverErrorHTTPResponse, Data())
        })
    }
}
