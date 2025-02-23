//
//  ProductsSalesMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 22/2/25.
//

import Testing
import Foundation
@testable import SalesTracker

struct ProductsSalesMapperTests: MapperSpecs {
    @Test func throws_authentication_error_on_401_status_code() async throws {
        #expect(throws: invalidCredentialsAuthError.error, performing: {
            _ = try ProductsSalesMapper.map(invalidAuthHTTPResponse, invalidCredentialsAuthError.http)
        })
    }
    
    @Test func throws_connectivity_error_on_not_found_status_code() async throws {
        #expect(throws: HTTPError.notFound, performing: {
            _ = try ProductsSalesMapper.map(notFoundHTTPResponse, Data())
        })
    }
    
    @Test func throws_decoding_error_on_invalid_data() async throws {
        #expect(throws: DecodingError.self, performing: {
            _ = try ProductsSalesMapper.map(successfulHTTPResponse, invalidData)
        })
    }
    
    @Test func returns_mapped_data_on_successful_200_status_code() async throws {
        #expect(try ProductsSalesMapper.map(successfulHTTPResponse, salesList.http) == salesList.decoded)
    }
    
    @Test func throws_other_error_on_other_http_status_code() async throws {
        #expect(throws: HTTPError.other, performing: {
            _ = try ProductsSalesMapper.map(serverErrorHTTPResponse, Data())
        })
    }
}

var salesList: (http: Data, decoded: [DecodableSale]) {
    (
        "[\(String(data: aSale.http, encoding: .utf8)!)]".data(using: .utf8)!,
        [aSale.decoded]
    )
}

var aSale: (http: Data, decoded: DecodableSale) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
    return (
        #"{"currency_code": "AUD", "amount": "1480.79", "product_id": "7019D8A7-0B35-4057-B7F9-8C5471961ED0", "date": "2024-07-20T15:45:27.366Z"}"#.data(using: .utf8)!,
        DecodableSale(
            product_id: UUID(uuidString: "7019D8A7-0B35-4057-B7F9-8C5471961ED0")!,
            amount: "1480.79",
            currency_code: "AUD",
            date: "2024-07-20T15:45:27.366Z"
        )
    )
}
