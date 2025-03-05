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
    case hidesError
}

final class ErrorDisplayableSpy: ErrorDisplayable {
    var isMainThread = false
    var errorDisplayMessages: [ErrorMessages] = []
    func display(_ error: any Error) {
        errorDisplayMessages.append(.displayedError)
        isMainThread = Thread.isMainThread
    }

    func removeError() {
        errorDisplayMessages.append(.hidesError)
    }
}
