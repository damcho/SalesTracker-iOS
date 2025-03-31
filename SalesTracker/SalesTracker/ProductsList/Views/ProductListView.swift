//
//  ProductListView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI

struct ProductListView: View {
    let navigationBarTitle: String
    let errorView: ErrorView

    let onRefresh: () async throws -> [ProductSalesView]
    @State var productSalesViews: [ProductSalesView] = []

    var body: some View {
        List {
            Section {
                ForEach(productSalesViews) { productSalesView in
                    productSalesView
                }
            } header: {
                errorView
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
        errorView: ErrorView(
            viewModel: ErrorViewModel()
        ),
        onRefresh: {
            [
                ProductSalesView(
                    viewModel: ProductSalesViewModel(
                        productInfo: ProductInfo(
                            product: .init(
                                id: UUID(),
                                name: "aname",
                                sales: []
                            ),
                            salesCount: 3
                        ),
                        selectedProductAction: { _ in }
                    )
                )
            ]
        }
    )
}
