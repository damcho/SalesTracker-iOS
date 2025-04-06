//
//  ProductListView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI

struct ProductListView: View {
    let navigationBarTitle: String

    let onRefresh: () async throws -> [ProductSalesView]
    @State var productSalesViews: [ProductSalesView] = []
    @State var activityIndicatoEnabled: Bool = false

    var body: some View {
        List {
            Section {
                ForEach(productSalesViews) { productSalesView in
                    productSalesView
                }
            }
        }
        .navigationTitle(Text(navigationBarTitle))
        .refreshable {
            await retrieveProducts()
        }.task {
            await retrieveProducts()
        }.enableActivityIndicator($activityIndicatoEnabled)
    }

    func retrieveProducts() async {
        do {
            activityIndicatoEnabled = true
            productSalesViews = try await onRefresh()
            activityIndicatoEnabled = false
        } catch {
            activityIndicatoEnabled = false
        }
    }
}

#Preview {
    ProductListView(
        navigationBarTitle: "Products",
        onRefresh: {
            [
                ProductSalesView(
                    viewModel: ProductSalesViewModel(
                        product: .init(
                            id: UUID(),
                            name: "aname",
                            sales: [],
                            currencyConverter: CurrencyConverter(currencyconversions: [])
                        )
                    )
                )
            ]
        }
    )
}
