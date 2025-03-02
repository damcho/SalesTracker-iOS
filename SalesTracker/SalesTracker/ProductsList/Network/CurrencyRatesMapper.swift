//
//  CurrencyRatesMapper.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import Foundation

struct DecodedCurrencyConvertion: Decodable {
    let from: String
    let to: String
    let rate: Double

    func toCurrencyConvertion() -> CurrencyConvertion {
        .init(
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
        case 400, 402 ..< 499:
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
