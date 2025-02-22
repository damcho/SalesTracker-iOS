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
                    productName: "a product",
                    salesAmount: "222 sales"
                )
            ),
            ProductSalesView(
                viewModel: ProductSalesViewModel(
                    productName: "a second product longer name",
                    salesAmount: "343 sales"
                )
            )
        ]
    )
}
