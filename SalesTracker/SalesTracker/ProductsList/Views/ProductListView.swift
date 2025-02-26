//
//  ProductListView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI

struct ProductListView: View {
    let onRefresh: () async throws -> [ProductSalesView]
    @State var productSalesViews: [ProductSalesView] = []
    var body: some View {
        List {
            ForEach(productSalesViews){ productSalesView in
                productSalesView
            }
        }.refreshable {
            do {
                productSalesViews = try await onRefresh()
            } catch { }
        }.task {
            do {
                productSalesViews = try await onRefresh()
            } catch { }
        }
    }
}

#Preview {
    ProductListView(
        onRefresh: {
            [
                ProductSalesView(
                    viewModel: ProductSalesViewModel(
                        productInfo: ProductInfo(
                            product: .init(
                                id:  UUID(),
                                name: "aname"),
                            salesCount: 3
                        ),
                        selectedProductAction: {_ in }
                    )
                )
            ]
        }
    )
}
