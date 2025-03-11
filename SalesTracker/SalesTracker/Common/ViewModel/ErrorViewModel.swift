//
//  ErrorViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

final class ErrorViewModel: ObservableObject {
    @Published var errorMessage: String = ""
}

// MARK: ErrorDisplayable

extension ErrorViewModel: ErrorDisplayable {
    func removeError() {
        errorMessage = ""
    }

    func display(_ error: any Error) {
        if let alocalizedError = error as? LocalizedError {
            errorMessage = alocalizedError.localizedDescription
        } else {
            errorMessage = "An error occurred."
        }
    }
}
