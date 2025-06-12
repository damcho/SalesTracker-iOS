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
            if !errorViewModel.errorMessage.isEmpty {
                if errorViewModel.shouldDisplayAlert {
                    content.alert(
                        errorViewModel.errorTitle,
                        isPresented: $errorViewModel.shouldDisplayAlert
                    ) {
                        Button("OK") {
                            errorViewModel.dismisErrorAction()
                        }
                    } message: {
                        Text(errorViewModel.errorMessage)
                    }
                } else {
                    content
                    ErrorView(errorText: $errorViewModel.errorMessage)
                        .transition(.move(edge: .top))
                        .onTapGesture {
                            errorViewModel.errorMessage = ""
                        }
                }
            } else {
                content
            }
        }
        .animation(.easeInOut, value: errorViewModel.errorMessage)
    }
}

extension View {
    func withErrorHandler(_ errorViewModel: ErrorViewModel) -> some View {
        modifier(ErrorViewModifier(errorViewModel: errorViewModel))
    }
}
