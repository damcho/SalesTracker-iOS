//
//  DecodableProduct.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation

struct DecodableProduct: Decodable {
    let id: UUID
    let name: String
    
    func toProduct() -> Product {
        return Product(id: id, name: name)
    }
}
