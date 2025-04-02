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
            .primaryListText()
        Text(viewModel.productSalesLabelText).secondaryListText()
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
