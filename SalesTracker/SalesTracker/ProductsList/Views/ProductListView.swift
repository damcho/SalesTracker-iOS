//
//  ProductListView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI

struct ProductListView: View {
    let onRefresh: () async -> [ProductSalesView]
    @State var productSalesViews: [ProductSalesView] = []
    var body: some View {
        List {
            ForEach(productSalesViews){ productSalesView in
                productSalesView
            }
        }.refreshable {
            productSalesViews = await onRefresh()
        }.task {
            productSalesViews = await onRefresh()
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
