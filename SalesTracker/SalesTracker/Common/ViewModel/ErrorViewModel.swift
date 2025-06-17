//
//  ErrorViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

enum SalesTrackerError: Error, Equatable {
    case authentication(String)
    case other(String)
}

// MARK: LocalizedError

extension SalesTrackerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .authentication(message):
            message
        case let .other(message):
            message
        }
    }
}

@MainActor
final class ErrorViewModel: ObservableObject {
    @Published var shouldDisplayAlert: Bool = false
    @Published var errorMessage: String = ""

    var alertErrorTitle = "Authentication Error"
    var alertErrorMessage = ""

    var dismisErrorAction: (() -> Void)?

    init(dismisErrorAction: (() -> Void)? = nil) {
        self.dismisErrorAction = dismisErrorAction
    }

    func removeErrorMessage() {
        errorMessage = ""
        shouldDisplayAlert = false
    }

    func dismiss() {
        removeErrorMessage()
        dismisErrorAction?()
    }
}

// MARK: ErrorDisplayable

extension ErrorViewModel: ErrorDisplayable {
    func display(_ error: SalesTrackerError) {
        switch error {
        case let .authentication(message):
            shouldDisplayAlert = true
            alertErrorMessage = message
        case let .other(message):
            shouldDisplayAlert = false
            errorMessage = message
        }
    }
}
