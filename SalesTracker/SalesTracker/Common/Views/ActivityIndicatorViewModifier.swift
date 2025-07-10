//
//  ActivityIndicatorViewModifier.swift
//  SalesTracker
//
//  Created by Damian Modernell on 5/4/25.
//

import Foundation
import SwiftUI

struct ActivityIndicatorViewModifier: ViewModifier {
    @Binding var shouldEnable: Bool
    func body(content: Content) -> some View {
        ZStack {
            content
            if shouldEnable {
                ProgressView().padding()
            }
        }
    }
}

extension View {
    func enableActivityIndicator(_ shouldEnable: Binding<Bool>) -> some View {
        modifier(ActivityIndicatorViewModifier(shouldEnable: shouldEnable))
    }
}
