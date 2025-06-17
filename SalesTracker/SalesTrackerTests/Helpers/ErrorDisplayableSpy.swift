//
//  ErrorDisplayableSpy.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 5/3/25.
//

import Foundation
@testable import SalesTracker

enum ErrorMessages {
    case displayedError
}

final class ErrorDisplayableSpy: ErrorDisplayable {
    func removeErrorMessage() {}

    var isMainThread = false
    var errorDisplayMessages: [ErrorMessages] = []
    func display(_ error: SalesTrackerError) {
        errorDisplayMessages.append(.displayedError)
        isMainThread = Thread.isMainThread
    }
}
