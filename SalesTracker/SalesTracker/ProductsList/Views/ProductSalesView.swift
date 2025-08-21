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
        } label: {
            HStack(spacing: 16) {
                // Product icon
                Image(systemName: "cube.box.fill")
                    .font(.system(.title2))
                    .foregroundStyle(.blue.gradient)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(Color.blue.opacity(0.1))
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.productName)
                        .lineLimit(2)
                        .primaryListText()
                        .multilineTextAlignment(.leading)

                    Text("Total Sales")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text(viewModel.salesAmount)
                        .font(.system(.title3, design: .rounded, weight: .semibold))
                        .foregroundColor(.primary)
                }
            }
            .padding(.vertical, 8)
        }
        .contentShape(Rectangle())
        .buttonStyle(PlainButtonStyle())
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
            )
        )
    )
}
