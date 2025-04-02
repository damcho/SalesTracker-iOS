//
//  ProductListAcceptanceTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 26/2/25.
//

import Foundation
import Testing

@testable import SalesTracker

struct ProductListAcceptanceTests {
    @Test
    func creates_product_sales_views_on_successful_load() async throws {
        let sut = await makeSUT(stub: .success([someProduct()]))

        let productSalesViews = try await sut.onRefresh()

        assertProductSalesViewModels(
            for: productSalesViews,
            expectedResult: [someProduct()]
        )
    }

    @Test
    func orders_products_by_products_name_asc() async throws {
        let shuffledProducts = [
            Product(id: UUID(), name: "product B", sales: [someSale], currencyConverter: anyCurrencyCOnverter),
            Product(id: UUID(), name: "product A", sales: [someSale], currencyConverter: anyCurrencyCOnverter),
            Product(id: UUID(), name: "product C", sales: [someSale], currencyConverter: anyCurrencyCOnverter)
        ]

        let sut = await makeSUT(stub: .success(shuffledProducts))

        let productSalesViews = try await sut.onRefresh()

        assertProductSalesViewModelsOrder(
            for: productSalesViews,
            expectedResult: ["product A", "product B", "product C"]
        )
    }
}

extension ProductListAcceptanceTests {
    func assertProductSalesViewModelsOrder(for views: [ProductSalesView], expectedResult: [String]) {
        let productsNames = views.map { view in
            view.viewModel.productName
        }

        #expect(productsNames == expectedResult)
    }

    func assertProductSalesViewModels(for views: [ProductSalesView], expectedResult: [Product]) {
        let productsInfoArray = views.map { view in
            view.viewModel.product
        }
        #expect(productsInfoArray == expectedResult)
    }

    @MainActor
    func makeSUT(stub: Result<[Product], Error>) -> ProductListView {
        ProductsListComposer.compose(
            with: ProductSalesLoadableStub(stub: stub),
            authErrorHandler: {}
        )
    }
}

struct ProductSalesLoadableStub: ProductSalesLoadable {
    let stub: Result<[Product], Error>
    func loadProductsAndSales() async throws -> [Product] {
        try stub.get()
    }
}

var someSale: Sale {
    Sale(date: .now, amount: 12.3, currencyCode: "USD")
}

func someProduct(
    sales: [Sale] = [],
    converter: CurrencyConverter = CurrencyConverter(currencyconversions: [])
)
    -> Product
{
    Product(
        id: UUID(uuidString: "7019D8A7-0B35-4057-B7F9-8C5471961ED0")!,
        name: "aname",
        sales: sales,
        currencyConverter: converter
    )
}

extension Product: @retroactive Equatable {
    public static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}
