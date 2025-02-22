//
//  ProductSalesView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI



struct ProductSalesView: View, Identifiable {
    let id = UUID()
    let viewModel: ProductSalesViewModel
    
    var body: some View {
        HStack(spacing: 10, content: {
            Text(viewModel.productName).lineLimit(2)
            Spacer()
            Text(viewModel.salesAmount)
        }).padding()
    }
}

#Preview {
    ProductSalesView(
        viewModel: ProductSalesViewModel(
            productName: "Product A is a very long long product name",
            salesAmount: "234 Sales"
        )
    )
}
