//
//  ErrorViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

@MainActor
final class ErrorViewModel: ObservableObject {
    @Published var shouldDisplayAlert: Bool = false
    var alertErrorTitle: String = ""
    var alertErrorMessage: String = ""

    let dismisErrorAction: () -> Void

    init(dismisErrorAction: @escaping () -> Void) {
        self.dismisErrorAction = dismisErrorAction
    }
}

// MARK: ErrorDisplayable

extension ErrorViewModel: ErrorDisplayable {
    func display(_ error: any Error) {
        shouldDisplayAlert = true
        alertErrorTitle = "Authentication Error"
        alertErrorMessage = error.localizedDescription
    }
}
