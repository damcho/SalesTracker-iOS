//
//  ProductSalesTotalAmountView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import SwiftUI

struct ProductSalesTotalAmountViewModel {
    let totalSalesAmount: Double
    let salesCount: Int
    let product: Product
    
    var productSalesLabelText: String {
        return "sales label"
    }
}

struct ProductSalesTotalAmountView: View {
    let viewModel: ProductSalesTotalAmountViewModel
    
    var body: some View {
        Text(viewModel.product.name)
        Text(viewModel.productSalesLabelText)
    }
}

#Preview {
    ProductSalesTotalAmountView(
        viewModel: ProductSalesTotalAmountViewModel(
            totalSalesAmount: 10.3,
            salesCount: 3,
            product: Product(
                id: UUID(),
                name: "Product A"
            )
        )
    )
}
