//
//  ProductListView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI

struct ProductListView: View {
    let productSalesViews: [ProductSalesView]
    var body: some View {
        List {
            ForEach(productSalesViews){ productSalesView in
                productSalesView
            }
        }
    }
}

#Preview {
    ProductListView(
        productSalesViews: [
            ProductSalesView(
                viewModel: ProductSalesViewModel(
                    productInfo: ProductInfo(
                        productId: UUID()
                    ),
                    selectedProductAction: {_ in }
                )
            ),
            ProductSalesView(
                viewModel: ProductSalesViewModel(
                    productInfo: ProductInfo(
                        productId: UUID()
                    ),
                    selectedProductAction: {_ in }
                )
            )
        ]
    )
}
