//
//  SaleDetailView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 28/2/25.
//

import SwiftUI

struct SaleDetailView: View, Identifiable {
    var id: UUID { UUID() }

    let viewModel: SaleDetailViewModel

    var body: some View {
        VStack(spacing: 12) {
            // Main sale amounts
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Local Amount")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.secondary)

                    Text(viewModel.localCurrencySaleAmount)
                        .font(.system(.title3, design: .rounded, weight: .semibold))
                        .foregroundColor(.primary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("Converted")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.secondary)

                    Text(viewModel.convertedCurrencySaleAmount)
                        .font(.system(.title3, design: .rounded, weight: .semibold))
                        .foregroundColor(.green)
                }
            }

            // Date and transaction info
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                        .font(.system(.caption2))
                        .foregroundColor(.secondary)

                    Text(viewModel.saleDate)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.secondary)
                }

                Spacer()

                HStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(.caption))
                        .foregroundColor(.green)

                    Text("Completed")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    SaleDetailView(
        viewModel: SaleDetailViewModel(
            sale: Sale(
                date: .now,
                amount: 133_432.34,
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
}
