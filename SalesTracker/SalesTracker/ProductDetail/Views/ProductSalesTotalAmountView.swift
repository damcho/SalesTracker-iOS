//
//  ProductSalesTotalAmountView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import SwiftUI

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
            ),
            currencyCode: "USD"
        )
    )
}
