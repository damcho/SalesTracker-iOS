//
//  ProductsListMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 22/2/25.
//

import Testing
@testable import SalesTracker
import Foundation

struct ProductsListMapperTests: MapperSpecs {
    
    @Test func throws_authentication_error_on_401_status_code() async throws {
        #expect(throws: invalidCredentialsAuthError.error, performing: {
            _ = try ProductsListMapper.map(invalidAuthHTTPResponse, invalidCredentialsAuthError.http)
        })
    }
    
    @Test  func throws_connectivity_error_on_not_found_status_code() async throws {
        #expect(throws: HTTPError.notFound, performing: {
            _ = try ProductsListMapper.map(notFoundHTTPResponse, Data())
        })
    }
    
    @Test func throws_decoding_error_on_invalid_data() async throws {
        #expect(throws: DecodingError.self, performing: {
            _ = try ProductsListMapper.map(successfulHTTPResponse, invalidData)
        })
    }
    
    @Test func returns_mapped_data_on_successful_200_status_code() async throws {
        #expect(try ProductsListMapper.map(successfulHTTPResponse, productListData.http) == [aProduct.domain])
    }
    
    @Test func throws_other_error_on_other_http_status_code() async throws {
        #expect(throws: HTTPError.other, performing: {
            _ = try ProductsListMapper.map(serverErrorHTTPResponse, Data())
        })
    }
}

var productListData: (http: Data, decoded: [Product]) {
    (
        #"[{"id": "7019D8A7-0B35-4057-B7F9-8C5471961ED0", "name": "some productname"}]"#.data(using: .utf8)!,
        [aProduct.domain]
    )
}

var aProduct: (http: Data, domain: Product) {
    (
        #"{"id": "7019D8A7-0B35-4057-B7F9-8C5471961ED0", "name": "some productname"}"#.data(using: .utf8)!,
        Product(
            id: UUID(uuidString: "7019D8A7-0B35-4057-B7F9-8C5471961ED0")!,
            name: "some productname"
        )
    )
}
