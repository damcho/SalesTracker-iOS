//
//  CurrencyRatesMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 28/2/25.
//

import Testing
import Foundation
@testable import SalesTracker

enum CurrencyRatesMapper {
    static func map(_ httpResponse: (data: Data, http: HTTPURLResponse)) throws -> [CurrencyConvertion] {
        throw HTTPError.notFound
    }
}

struct CurrencyRatesMapperTests: MapperSpecs {
    @Test func throws_connectivity_error_on_not_found_status_code() async throws {
        #expect(throws: HTTPError.notFound, performing: {
            _ = try CurrencyRatesMapper.map((invalidCredentialsAuthError.http, invalidAuthHTTPResponse))
        })
    }
    
    @Test func throws_decoding_error_on_invalid_data() async throws {
        
    }
    
    @Test func returns_mapped_data_on_successful_200_status_code() async throws {
        
    }
    
    @Test func throws_other_error_on_other_http_status_code() async throws {
        
    }

}

