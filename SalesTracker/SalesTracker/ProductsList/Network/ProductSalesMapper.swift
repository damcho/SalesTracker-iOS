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
    
    func toSale() throws -> RemoteSale {
        guard let aDate = DecodableSale.dateFormatter.date(from: date),
              let anAmount = Double(amount) else {
            throw ProductSalesMapperError.decoding
        }
        return RemoteSale(
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
    
    static func map(_ response: HTTPURLResponse, _ data: Data) throws -> [RemoteSale] {
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
                try? decodedProduct.toSale()
            })
        default:
            throw HTTPError.other
        }
    }
}
