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
        VStack(spacing: 16) {
            // Product header
            HStack(spacing: 12) {
                Image(systemName: "cube.box.fill")
                    .font(.system(.title))
                    .foregroundStyle(.blue.gradient)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(Color.blue.opacity(0.1))
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.product.name)
                        .font(.system(.title2, design: .rounded, weight: .bold))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    Text("Product Details")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.secondary)
                }

                Spacer()
            }

            // Sales summary card
            VStack(spacing: 12) {
                HStack {
                    Text("Total Sales")
                        .font(.system(.subheadline, design: .rounded, weight: .medium))
                        .foregroundColor(.secondary)
                    Spacer()
                }

                HStack {
                    Text(viewModel.productSalesLabelText)
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemGroupedBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
            )
        }
    }
}

#Preview {
    ProductSalesTotalAmountView(
        viewModel: ProductSalesTotalAmountViewModel(
            product: Product(
                id: UUID(),
                name: "Product A",
                sales: [],
                currencyConverter: CurrencyConverter(currencyconversions: [])
            ),
            currencyCode: "USD"
        )
    )
}
