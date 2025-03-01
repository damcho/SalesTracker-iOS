//
//  CurrencyRatesMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 28/2/25.
//

import Testing
import Foundation
@testable import SalesTracker

struct DecodedCurrencyConvertion: Decodable {
    let from: String
    let to: String
    let rate: Double
    
    func toCurrencyConvertion() -> CurrencyConvertion {
        return .init(
            fromCurrencyCode: from,
            toCurrencyCode: to,
            rate: rate
        )
    }
}

enum CurrencyRatesMapper {
    static let success = 200

    static func map(_ result: (data: Data, httpResponse: HTTPURLResponse)) throws -> [CurrencyConvertion] {
        switch result.httpResponse.statusCode {
        case 400, 402..<499:
            throw HTTPError.notFound
        case success:
            return try JSONDecoder().decode(
                [DecodedCurrencyConvertion].self,
                from: result.data
            ).compactMap { decodedCurrencyConversion in
                decodedCurrencyConversion.toCurrencyConvertion()
            }
        default:
            throw HTTPError.other
        }
    }
}

struct CurrencyRatesMapperTests: MapperSpecs {
    @Test func throws_connectivity_error_on_not_found_status_code() async throws {
        #expect(throws: HTTPError.notFound, performing: {
            _ = try CurrencyRatesMapper.map((Data(), notFoundHTTPResponse))
        })
    }
    
    @Test func throws_decoding_error_on_invalid_data() async throws {
        #expect(throws: DecodingError.self, performing: {
            _ = try CurrencyRatesMapper.map((invalidData, successfulHTTPResponse))
        })
    }
    
    @Test func returns_mapped_data_on_successful_200_status_code() async throws {
        #expect(try CurrencyRatesMapper.map(( currencyRates.http, successfulHTTPResponse)) == [currencyRates.decoded])
    }
    
    @Test func throws_other_error_on_other_http_status_code() async throws {
        #expect(throws: HTTPError.other, performing: {
            _ = try CurrencyRatesMapper.map((Data(), serverErrorHTTPResponse))
        })
    }

}

var currencyRates: (http: Data, decoded: CurrencyConvertion) {
    (
        #"[{"from": "USD","to": "ARS","rate": 123.45}]"#.data(using: .utf8)!,
        CurrencyConvertion(
            fromCurrencyCode: "USD",
            toCurrencyCode: "ARS",
            rate: 123.45
        )
    )
}

