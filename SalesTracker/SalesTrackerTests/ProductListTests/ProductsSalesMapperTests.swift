//
//  ProductsSalesMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 22/2/25.
//

import Testing
import Foundation
@testable import SalesTracker

enum ProductsSalesMapper {
    static let unauthorized = 401
    static let success = 200
    
    static func map(_ response: HTTPURLResponse, _ data: Data) throws -> [Product] {
        switch response.statusCode {
        case unauthorized:
            let errorData = try JSONDecoder().decode(
                DecodableHTTPErrorMessage.self,
                from: data
            )
            throw LoginError.authentication(errorData.message)
        case 400, 402..<499:
            throw HTTPError.notFound
        case success:
            return try JSONDecoder().decode(
                [DecodableProduct].self,
                from: data
            ).compactMap({ decodedProduct in
                decodedProduct.toProduct()
            })
        default:
            throw HTTPError.other
        }
    }
}

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
        
    }
    
    @Test func throws_other_error_on_other_http_status_code() async throws {
        
    }

}
