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
            do {
                productSalesViews = try await onRefresh()
            } catch {}
        }.task {
            do {
                productSalesViews = try await onRefresh()
            } catch {}
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
