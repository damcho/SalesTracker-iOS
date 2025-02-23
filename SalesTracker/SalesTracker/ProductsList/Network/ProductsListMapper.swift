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
    
    func toProduct() -> Product {
        return Product(id: id, name: name)
    }
}

enum ProductsListMapper {
    static let unauthorized = 401
    static let success = 200
    
    static func map(_ response: HTTPURLResponse, _ data: Data) throws -> [DecodableProduct] {
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
            )
        default:
            throw HTTPError.other
        }
    }
}
