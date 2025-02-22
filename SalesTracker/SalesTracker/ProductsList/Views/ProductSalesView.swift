//
//  ProductSalesView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI

struct ProductSalesView: View {
    var body: some View {
        HStack(spacing: 10, content: {
            Text("Product A is a very long long product name").lineLimit(2)
            Spacer()
            Text("234 Sales")
        }).padding()
    }
}

#Preview {
    ProductSalesView()
}
