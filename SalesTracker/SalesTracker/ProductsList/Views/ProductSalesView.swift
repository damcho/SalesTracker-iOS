//
//  ProductSalesView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI



struct ProductSalesView: View, Identifiable {
    var id: UUID { viewModel.productInfo.product.id }
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
                product: .init(
                    id: UUID(),
                    name: "a name"
                ),
                salesCount: 3
            ),
            selectedProductAction: {_ in print("Tapped")}
        )
    )
}
