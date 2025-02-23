//
//  ProductInfoMapperTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 23/2/25.
//

import Testing
@testable import SalesTracker
import Foundation

struct Sale: Equatable {
    let date: Date
    let amount: Double
    let currencyCode: String
}

enum ProductInfoMapper {
    static func map(_ products: [DecodableProduct], _ sales: [RemoteSale]) -> [Product: [Sale]] {
        var productsDictionary: [UUID: Product] = [:]
        var productsSalesDictionary: [Product: [Sale]] = [:]

        products.forEach { product in
            let aProduct = Product(id: product.id, name: product.name)
            productsDictionary[product.id] = aProduct
            productsSalesDictionary[aProduct] = []
        }
        sales.forEach { remotesale in
            if let aProduct = productsDictionary[remotesale.productID] {
                productsSalesDictionary[aProduct]?.append(remotesale.toSale())
            }
        }
        return productsSalesDictionary
    }
}

extension RemoteSale {
    func toSale() -> Sale {
        Sale(date: date, amount: amount, currencyCode: currencyCode)
    }
}

struct ProductInfoMapperTests {
    
    @Test func maps_products_and_sales_to_product_sales_dictionary() async throws {
        let decodedProductUUID = UUID()
        let anotherDecodedProductUUID = UUID()
        let productsList = [
            aProduct(id: decodedProductUUID).decoded,
            aProduct(id: anotherDecodedProductUUID).decoded
        ]
        let salesList: [RemoteSale] = [
            aRemoteSale(for: decodedProductUUID),
            aRemoteSale(for: anotherDecodedProductUUID)
        ]
        
        let result = ProductInfoMapper.map(productsList, salesList)
        #expect(
            result == [
                aProduct(id: decodedProductUUID).domain: [salesList[0].toSale()],
                aProduct(id: anotherDecodedProductUUID).domain: [salesList[1].toSale()],
            ]
        )
    }
    
    @Test func ignores_sale_that_does_not_match_any_product() async throws {
        let decodedProductUUID = UUID()
        let anotherDecodedProductUUID = UUID()
        let productsList = [
            aProduct(id: decodedProductUUID).decoded,
            aProduct(id: anotherDecodedProductUUID).decoded
        ]
        let salesList: [RemoteSale] = [
            aRemoteSale(for: decodedProductUUID),
            aRemoteSale(for: invalidProductID)
        ]
        
        let result = ProductInfoMapper.map(productsList, salesList)
        #expect(
            result == [
                aProduct(id: decodedProductUUID).domain: [salesList[0].toSale()],
                aProduct(id: anotherDecodedProductUUID).domain: []
            ]
        )
    }
}

var invalidProductID: UUID {
    UUID()
}

func aProduct(id: UUID) -> (domain: Product, decoded: DecodableProduct) {
    (
        Product(id: id, name: "some productname"),
        DecodableProduct(
            id: id,
            name: "some productname"
        )
    )
}

func aRemoteSale(for productid: UUID) -> RemoteSale {
    RemoteSale(
        productID: productid,
        date: .now,
        amount: 10.2,
        currencyCode: "USD"
    )
}
