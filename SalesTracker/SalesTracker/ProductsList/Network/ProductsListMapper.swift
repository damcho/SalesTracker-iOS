//
//  ProductsListMapper.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation

struct DecodableProduct: Decodable, Equatable {
    let id: UUID
    let name: String
}

enum ProductsListMapper {
    static let unauthorized = 401
    static let success = 200

    static func map(_ result: (data: Data, httpResponse: HTTPURLResponse)) throws -> [DecodableProduct] {
        switch result.httpResponse.statusCode {
        case unauthorized:
            let errorData = try JSONDecoder().decode(
                DecodableHTTPErrorMessage.self,
                from: result.data
            )
            throw SalesTrackerError.authentication(errorData.message)
        case 400, 402 ..< 499:
            throw HTTPError.notFound
        case success:
            return try JSONDecoder().decode(
                [DecodableProduct].self,
                from: result.data
            )
        default:
            throw HTTPError.other
        }
    }
}
