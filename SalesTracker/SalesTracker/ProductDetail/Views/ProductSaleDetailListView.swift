//
//  ProductSaleDetailListView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import SwiftUI

struct ProductSaleDetailListView: View {
    @State var saleDetailViews: [SaleDetailView]
    let headerSection: ProductSalesTotalAmountView

    var body: some View {
        VStack(spacing: 0) {
            // Header section with enhanced styling
            VStack(spacing: 16) {
                headerSection
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
                    .background(
                        LinearGradient(
                            colors: [
                                Color(.systemBackground),
                                Color(.systemGray6).opacity(0.3)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }

            // Sales list
            if saleDetailViews.isEmpty {
                // Empty state
                VStack(spacing: 20) {
                    Image(systemName: "chart.line.downtrend.xyaxis")
                        .font(.system(size: 50))
                        .foregroundStyle(.secondary)

                    Text("No Sales Data")
                        .font(.system(.title3, design: .rounded, weight: .semibold))
                        .foregroundColor(.primary)

                    Text("Sales information will appear here when available")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGroupedBackground))
            } else {
                List {
                    Section {
                        ForEach(saleDetailViews) { saleDetailView in
                            saleDetailView
                                .listRowBackground(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemBackground))
                                        .padding(.vertical, 2)
                                )
                        }
                    } header: {
                        HStack {
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.blue)
                                .font(.system(.subheadline))

                            Text("Sales History")
                                .font(.system(.subheadline, design: .rounded, weight: .medium))
                                .foregroundColor(.primary)

                            Spacer()

                            Text("\(saleDetailViews.count) transactions")
                                .font(.system(.caption, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal, 4)
                    }
                    .listSectionSeparator(.hidden)
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(Color(.systemGroupedBackground))
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    ProductSaleDetailListView(
        saleDetailViews: [
            SaleDetailView(
                viewModel: SaleDetailViewModel(
                    sale: Sale(
                        date: .now,
                        amount: 134_543.23,
                        currencyCode: "ARS"
                    ),
                    dateFormat: .dateTime,
                    currencyconversion: CurrencyConversion(
                        fromCurrencyCode: "ARS",
                        toCurrencyCode: "USD",
                        rate: 1 / 1000
                    )
                )
            )
        ],
        headerSection: ProductSalesTotalAmountView(
            viewModel: ProductSalesTotalAmountViewModel(
                product: Product(
                    id: UUID(),
                    name: "Product A",
                    sales: [],
                    currencyConverter: CurrencyConverter(currencyconversions: [])
                ),
                currencyCode: "ARS"
            )
        )
    )
}
