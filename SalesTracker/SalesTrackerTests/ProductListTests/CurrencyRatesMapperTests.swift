//
//  CurrencyRatesMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation
@testable import SalesTracker
import Testing

struct CurrencyRatesMapperTests: MapperSpecs {
    @Test
    func throws_connectivity_error_on_not_found_status_code() async throws {
        #expect(throws: HTTPError.notFound, performing: {
            _ = try CurrencyRatesMapper.map((Data(), notFoundHTTPResponse))
        })
    }

    @Test
    func throws_decoding_error_on_invalid_data() async throws {
        #expect(throws: DecodingError.self, performing: {
            _ = try CurrencyRatesMapper.map((invalidData, successfulHTTPResponse))
        })
    }

    @Test
    func returns_mapped_data_on_successful_200_status_code() async throws {
        #expect(try CurrencyRatesMapper.map((currencyRates.http, successfulHTTPResponse)) == [currencyRates.decoded])
    }

    @Test
    func throws_other_error_on_other_http_status_code() async throws {
        #expect(throws: HTTPError.other, performing: {
            _ = try CurrencyRatesMapper.map((Data(), serverErrorHTTPResponse))
        })
    }
}

var currencyRates: (http: Data, decoded: CurrencyConversion) {
    (
        #"[{"from": "USD","to": "ARS","rate": 123.45}]"#.data(using: .utf8)!,
        CurrencyConversion(
            fromCurrencyCode: "USD",
            toCurrencyCode: "ARS",
            rate: 123.45
        )
    )
}
