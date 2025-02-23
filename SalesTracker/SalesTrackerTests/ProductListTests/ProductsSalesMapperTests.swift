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
        #expect(try ProductsSalesMapper.map(successfulHTTPResponse, salesList.http) == salesList.domain)
    }
    
    @Test func throws_other_error_on_other_http_status_code() async throws {
        #expect(throws: HTTPError.other, performing: {
            _ = try ProductsSalesMapper.map(serverErrorHTTPResponse, Data())
        })
    }
    
    @Test func ignores_malformed_sale_object_with_incorrect_date_format() async throws {
        #expect(try ProductsSalesMapper.map(successfulHTTPResponse, salesListWithMalformedSale.http) == salesListWithMalformedSale.domain)
    }

}

var salesList: (http: Data, domain: [RemoteSale]) {
    (
        "[\(String(data: aSale.http, encoding: .utf8)!)]".data(using: .utf8)!,
        [aSale.domain]
    )
}
    
var malformedSaleWithIncorrectDateFormat: Data {
    return #"{"currency_code": "AUD", "amount": "1480.79", "product_id": "7019D8A7-0B35-4057-B7F9-8C5471961ED0", "date": "2024-07-2025"}"#.data(using: .utf8)!
}

var salesListWithMalformedSale: (http: Data, domain: [RemoteSale]) {
    (
        "[\(String(data: aSale.http, encoding: .utf8)!),\(String(data: malformedSaleWithIncorrectDateFormat, encoding: .utf8)!)]".data(using: .utf8)!,
        [aSale.domain]
    )
}

var aSale: (http: Data, domain: RemoteSale) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
    return (
        #"{"currency_code": "AUD", "amount": "1480.79", "product_id": "7019D8A7-0B35-4057-B7F9-8C5471961ED0", "date": "2024-07-20T15:45:27.366Z"}"#.data(using: .utf8)!,
        RemoteSale(
            productID: UUID(uuidString: "7019D8A7-0B35-4057-B7F9-8C5471961ED0")!,
            date: dateFormatter.date(from: "2024-07-20T15:45:27.366Z")!,
            amount: 1480.79,
            currencyCode: "AUD"
        )
    )
}
