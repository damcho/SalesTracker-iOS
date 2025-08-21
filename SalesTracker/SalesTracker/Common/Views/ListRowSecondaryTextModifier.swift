//
//  ListRowSecondaryTextModifier.swift
//  SalesTracker
//
//  Created by Damian Modernell on 31/3/25.
//

import Foundation
import SwiftUI

struct ListRowSecondaryTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.subheadline, design: .rounded))
            .foregroundColor(.secondary)
    }
}

extension View {
    func secondaryListText() -> some View {
        modifier(ListRowSecondaryTextModifier())
    }
}
