//
//  ProductInfoMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 23/2/25.
//

import Testing
@testable import SalesTracker
import Foundation

struct ProductInfoMapperTests {
    
    @Test func maps_products_and_sales_to_product_sales_dictionary() async throws {
        let decodedProductUUID = UUID()
        let anotherDecodedProductUUID = UUID()
        let productsList = [
            aDecodedProduct(id: decodedProductUUID).decoded,
            aDecodedProduct(id: anotherDecodedProductUUID).decoded
        ]
        let salesList: [DecodableSale] = [
            aDecodedSale(for: decodedProductUUID),
            aDecodedSale(for: anotherDecodedProductUUID)
        ]
        
        let result = ProductInfoMapper.map(productsList, salesList)
        #expect(
            result == [
                aDecodedProduct(id: decodedProductUUID).domain: try! [salesList[0].toSale()],
                aDecodedProduct(id: anotherDecodedProductUUID).domain: try! [salesList[1].toSale()],
            ]
        )
    }
    
    @Test func ignores_sale_that_does_not_match_any_product() async throws {
        let decodedProductUUID = UUID()
        let anotherDecodedProductUUID = UUID()
        let productsList = [
            aDecodedProduct(id: decodedProductUUID).decoded,
            aDecodedProduct(id: anotherDecodedProductUUID).decoded
        ]
        let salesList: [DecodableSale] = [
            aDecodedSale(for: decodedProductUUID),
            aDecodedSale(for: invalidProductID)
        ]
        
        let result = ProductInfoMapper.map(productsList, salesList)
        #expect(
            result == [
                aDecodedProduct(id: decodedProductUUID).domain: try! [salesList[0].toSale()],
                aDecodedProduct(id: anotherDecodedProductUUID).domain: []
            ]
        )
    }
}

var invalidProductID: UUID {
    UUID()
}

func aDecodedProduct(id: UUID) -> (domain: Product, decoded: DecodableProduct) {
    (
        Product(id: id, name: "some productname"),
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
