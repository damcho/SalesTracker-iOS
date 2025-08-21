//
//  ProductListView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import SwiftUI

struct ProductListView: View {
    let navigationBarTitle: String

    let onRefresh: () async throws -> [ProductSalesView]
    @State var productSalesViews: [ProductSalesView] = []
    @State var activityIndicatoEnabled: Bool = false

    var body: some View {
        Group {
            if productSalesViews.isEmpty, !activityIndicatoEnabled {
                EmptyProductListView()
            } else {
                List {
                    Section {
                        ForEach(productSalesViews) { productSalesView in
                            productSalesView
                                .listRowBackground(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemBackground))
                                        .padding(.vertical, 2)
                                )
                        }
                    } header: {
                        if !productSalesViews.isEmpty {
                            HStack {
                                Text("Your Products")
                                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(productSalesViews.count) items")
                                    .font(.system(.caption, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 4)
                        }
                    }
                    .listSectionSeparator(.hidden)
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(Color(.systemGroupedBackground))
            }
        }
        .navigationTitle(Text(navigationBarTitle))
        .navigationBarTitleDisplayMode(.large)
        .refreshable {
            await retrieveProducts()
        }
        .task {
            await retrieveProducts()
        }
        .enableActivityIndicator($activityIndicatoEnabled)
    }

    func retrieveProducts() async {
        do {
            activityIndicatoEnabled = productSalesViews.isEmpty
            productSalesViews = try await onRefresh()
            activityIndicatoEnabled = false
        } catch {
            activityIndicatoEnabled = false
        }
    }
}

#Preview {
    ProductListView(
        navigationBarTitle: "Products",
        onRefresh: {
            [
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
            ]
        }
    )
}
