//
//  CurrencyRatesMapper.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

struct DecodedCurrencyconversion: Decodable {
    let from: String
    let to: String
    let rate: Double

    func toCurrencyconversion() -> CurrencyConversion {
        .init(
            fromCurrencyCode: from,
            toCurrencyCode: to,
            rate: rate
        )
    }
}

enum CurrencyRatesMapper {
    static let success = 200

    static func map(_ result: (data: Data, httpResponse: HTTPURLResponse)) throws -> [CurrencyConversion] {
        switch result.httpResponse.statusCode {
        case 400, 402 ..< 499:
            throw HTTPError.notFound
        case success:
            return try JSONDecoder().decode(
                [DecodedCurrencyconversion].self,
                from: result.data
            ).compactMap { decodedCurrencyConversion in
                decodedCurrencyConversion.toCurrencyconversion()
            }
        default:
            throw HTTPError.other
        }
    }
}
