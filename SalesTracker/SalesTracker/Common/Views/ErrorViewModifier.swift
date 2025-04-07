//
//  ErrorViewModifier.swift
//  SalesTracker
//
//  Created by Damian Modernell on 4/4/25.
//

import Foundation
import SwiftUI

struct ErrorViewModifier: ViewModifier {
    @StateObject var errorViewModel: ErrorViewModel
    func body(content: Content) -> some View {
        content
            .alert(
                errorViewModel.alertErrorTitle,
                isPresented: $errorViewModel.shouldDisplayAlert,
            ) {
                Button("OK") {
                    errorViewModel.dismisErrorAction()
                }
            } message: {
                Text(errorViewModel.alertErrorMessage)
            }
    }
}

extension View {
    func withErrorHandler(_ errorViewModel: ErrorViewModel) -> some View {
        modifier(ErrorViewModifier(errorViewModel: errorViewModel))
    }
}
