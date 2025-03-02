//
//  ProductInfoMapper.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

enum ProductInfoMapper {
    static func map(_ products: [DecodableProduct], _ sales: [DecodableSale]) -> [Product: [Sale]] {
        var productsDictionary: [UUID: Product] = [:]
        var productsSalesDictionary: [Product: [Sale]] = [:]

        for decodedProduct in products {
            let aProduct = Product(id: decodedProduct.id, name: decodedProduct.name)
            productsDictionary[decodedProduct.id] = aProduct
            productsSalesDictionary[aProduct] = []
        }
        for decodedSale in sales {
            if let aProduct = productsDictionary[decodedSale.product_id] {
                try? productsSalesDictionary[aProduct]?.append(decodedSale.toSale())
            }
        }
        return productsSalesDictionary
    }
}
