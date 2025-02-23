//
//  ProductSalesMapper.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

enum ProductSalesMapperError: Error {
    case decoding
}

struct DecodableSale: Decodable, Equatable {
    let product_id: UUID
    let amount: String
    let currency_code: String
    let date: Date
    
    func toSale() throws -> Sale {
        guard let anAmount = Double(amount) else {
            throw ProductSalesMapperError.decoding
        }
        return Sale(
            date: date,
            amount: anAmount,
            currencyCode: currency_code
        )
    }
}

struct ProductsSalesMapper {
    let unauthorized = 401
    let success = 200
    let dateFormatter: DateFormatter
    
    func map(_ response: HTTPURLResponse, _ data: Data) throws -> [DecodableSale] {
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
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return try decoder.decode(
                [DecodableSale].self,
                from: data
            )
        default:
            throw HTTPError.other
        }
    }
}
