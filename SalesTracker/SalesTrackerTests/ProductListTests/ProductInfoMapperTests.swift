//
//  ProductInfoMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation
@testable import SalesTracker
import Testing

struct ProductInfoMapperTests {
    @Test
    func maps_products_and_sales_to_products() async throws {
        let decodedProductUUID = UUID()
        let anotherDecodedProductUUID = UUID()
        let sale1 = aDecodedSale(for: decodedProductUUID)
        let sale2 = aDecodedSale(for: anotherDecodedProductUUID)

        let product1 = try aDecodedProduct(id: decodedProductUUID, sales: [sale1.toSale()])
        let product2 = try aDecodedProduct(
            id: anotherDecodedProductUUID,
            sales: [sale2.toSale()]
        )

        let result = try ProductInfoMapper.map([product1.decoded, product2.decoded], [sale1, sale2])
        print(result)
        #expect(
            try result == [
                product1.domain,
                product2.domain
            ]
        )
    }

    @Test
    func ignores_sale_that_does_not_match_any_product() async throws {
        let decodedProductUUID = UUID()
        let anotherDecodedProductUUID = UUID()

        let sale1 = aDecodedSale(for: decodedProductUUID)
        let sale2 = aDecodedSale(for: invalidProductID)

        let product1 = try aDecodedProduct(id: decodedProductUUID, sales: [sale1.toSale()])
        let product2 = aDecodedProduct(
            id: anotherDecodedProductUUID,
            sales: []
        )

        let result = try ProductInfoMapper.map([product1.decoded, product2.decoded], [sale1, sale2])
        #expect(
            try
                result == [
                    product1.domain,
                    product2.domain
                ]
        )
    }
}

var invalidProductID: UUID {
    UUID()
}

func aDecodedProduct(id: UUID, sales: [Sale] = []) -> (domain: Product, decoded: DecodableProduct) {
    (
        Product(id: id, name: "some productname", sales: sales),
        DecodableProduct(
            id: id,
            name: "some productname"
        )
    )
}

func aDecodedSale(for productid: UUID) -> DecodableSale {
    DecodableSale(
        product_id: productid,
        amount: "10.2",
        currency_code: "USD",
        date: .now
    )
}
