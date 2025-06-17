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
        ZStack {
            content.alert(
                errorViewModel.alertErrorTitle,
                isPresented: $errorViewModel.shouldDisplayAlert
            ) {
                Button("OK") {
                    errorViewModel.dismiss()
                }
            } message: {
                Text(errorViewModel.alertErrorMessage)
            }
            ErrorView(errorText: $errorViewModel.errorMessage)
                .transition(.move(edge: .top))
        }
        .animation(.easeInOut, value: errorViewModel.errorMessage)
    }
}

extension View {
    func withErrorHandler(_ errorViewModel: ErrorViewModel) -> some View {
        modifier(ErrorViewModifier(errorViewModel: errorViewModel))
    }
}
