//
//  ProductInfoMapper.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

enum ProductInfoMapper {
    static func map(_ decodedproducts: [DecodableProduct], _ sales: [DecodableSale]) throws -> [Product] {
        var products: [Product] = []
        for decodedProduct in decodedproducts {
            try products.append(Product(
                id: decodedProduct.id,
                name: decodedProduct.name,
                sales: sales.filter { decodableSale in
                    decodableSale.product_id == decodedProduct.id
                }.map { decodableSale in try decodableSale.toSale() }
            ))
        }

        return products
    }
}
