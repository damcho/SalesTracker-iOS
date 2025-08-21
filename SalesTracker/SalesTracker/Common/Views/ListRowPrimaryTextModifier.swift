//
//  ListRowPrimaryTextModifier.swift
//  SalesTracker
//
//  Created by Damian Modernell on 31/3/25.
//

import Foundation
import SwiftUI

struct ListRowPrimaryTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title3, design: .rounded, weight: .medium))
            .foregroundColor(.primary)
    }
}

extension View {
    func primaryListText() -> some View {
        modifier(ListRowPrimaryTextModifier())
    }
}
