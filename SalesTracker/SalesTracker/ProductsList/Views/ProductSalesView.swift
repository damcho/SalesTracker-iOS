//
//  ProductSalesView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI



struct ProductSalesView: View, Identifiable {
    var id: UUID { viewModel.productInfo.productId }
    let viewModel: ProductSalesViewModel
    
    var body: some View {
        HStack(spacing: 10, content: {
            Text(viewModel.productName).lineLimit(2)
            Spacer()
            Text(viewModel.salesAmount)
        }).onTapGesture {
            viewModel.didSelectProduct()
        }
    }
}

#Preview {
    ProductSalesView(
        viewModel: ProductSalesViewModel(
            productInfo: ProductInfo(
                productId: UUID(),
                name: "prod name",
                salesCount: 3
            ),
            selectedProductAction: {_ in print("Tapped")}
        )
    )
}
