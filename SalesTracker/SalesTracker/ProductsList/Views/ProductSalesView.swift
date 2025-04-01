//
//  ProductSalesView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI

struct ProductSalesView: View, Identifiable {
    var id: UUID { viewModel.product.id }
    let viewModel: ProductSalesViewModel

    var body: some View {
        NavigationLink {
            ProductDetailComposer.compose(
                with: viewModel.product
            )
            Text("hello world")
        } label: {
            HStack(spacing: 10, content: {
                Text(viewModel.productName).lineLimit(2).primaryListText()
                Spacer()
                Text(viewModel.salesAmount)
                    .primaryListText()
            })
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    ProductSalesView(
        viewModel: ProductSalesViewModel(
            product: .init(
                id: UUID(),
                name: "aname",
                sales: [],
                currencyConverter: CurrencyConverter(currencyconversions: [])
            ),
            selectedProductAction: { _ in print("Tapped") }
        )
    )
}
