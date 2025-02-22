//
//  ProductsListMapper.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation

enum ProductsListMapper {
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
