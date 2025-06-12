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
    var shouldDisplayAlert: Bool = false
    var errorTitle = ""
    @Published var errorMessage: String = ""

    let dismisErrorAction: () -> Void

    init(dismisErrorAction: @escaping () -> Void) {
        self.dismisErrorAction = dismisErrorAction
    }
}

// MARK: ErrorDisplayable

extension ErrorViewModel: ErrorDisplayable {
    func display(_ error: SalesTrackerError) {
        switch error {
        case let .authentication(message):
            errorTitle = "Authentication Error"
            shouldDisplayAlert = true
            errorMessage = message
        case let .other(message):
            errorTitle = ""
            shouldDisplayAlert = false
            errorMessage = message
        }
    }
}
