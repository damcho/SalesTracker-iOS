//
//  EmptyProductListView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/12/25.
//

import SwiftUI

struct EmptyProductListView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer()
                    .frame(minHeight: 100)

                Image(systemName: "chart.bar.doc.horizontal")
                    .font(.system(size: 60))
                    .foregroundStyle(.secondary)

                Text("No Products Yet")
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                    .foregroundColor(.primary)

                Text("Pull to refresh to load your products")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)

                Spacer()
                    .frame(minHeight: 200)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: UIScreen.main.bounds.height - 200) // Ensure minimum height for pull-to-refresh
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview("Light Mode") {
    EmptyProductListView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    EmptyProductListView()
        .preferredColorScheme(.dark)
}
