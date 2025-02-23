//
//  ProductsSalesMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 22/2/25.
//

import Testing
import Foundation
@testable import SalesTracker

enum ProductSalesMapperError: Error {
    case decoding
}

struct DecodableSale: Decodable {
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        return dateFormatter
    }
    
    let product_id: UUID
    let amount: String
    let currency_code: String
    let date: String
    
    func toSale() throws -> Sale {
        guard let aDate = DecodableSale.dateFormatter.date(from: date),
              let anAmount = Double(amount) else {
            throw ProductSalesMapperError.decoding
        }
        return Sale(
            productID: product_id,
            date: aDate,
            amount: anAmount,
            currencyCode: currency_code
        )
    }
}

enum ProductsSalesMapper {
    static let unauthorized = 401
    static let success = 200
    
    static func map(_ response: HTTPURLResponse, _ data: Data) throws -> [Sale] {
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
                [DecodableSale].self,
                from: data
            ).compactMap({ decodedProduct in
                try decodedProduct.toSale()
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
        #expect(try ProductsSalesMapper.map(successfulHTTPResponse, salesList.http) == [aSale.domain])
    }
    
    @Test func throws_other_error_on_other_http_status_code() async throws {
        
    }

}

var salesList: (http: Data, domain: [Sale]) {
    (
        "[\(String(data: aSale.http, encoding: .utf8)!)]".data(using: .utf8)!,
        [aSale.domain]
    )
}
    

var aSale: (http: Data, domain: Sale) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
    return (
        #"{"currency_code": "AUD", "amount": "1480.79", "product_id": "7019D8A7-0B35-4057-B7F9-8C5471961ED0", "date": "2024-07-20T15:45:27.366Z"}"#.data(using: .utf8)!,
        Sale(
            productID: UUID(uuidString: "7019D8A7-0B35-4057-B7F9-8C5471961ED0")!,
            date: dateFormatter.date(from: "2024-07-20T15:45:27.366Z")!,
            amount: 1480.79,
            currencyCode: "AUD"
        )
    )
}
