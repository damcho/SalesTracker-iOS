//
//  ErrorViewModelTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 3/3/25.
//

import Foundation
@testable import SalesTracker
import Testing

struct ErrorViewModelTests {
    @Test
    func displays_custom_error_message_on_localized_error_implemented() async throws {
        expect(
            LocalizedErrorImplementation.someLocalizedError.errorDescription!,
            for: LocalizedErrorImplementation.someLocalizedError
        )
        expect(
            "An error occurred.",
            for: anyError
        )
    }

    @Test
    func displays_empty_string_on_remove_error_called() async throws {
        let sut = ErrorViewModel()

        sut.removeError()

        #expect(sut.errorMessage == "")
    }

    func expect(_ expectedErrorMessage: String, for error: Error) {
        let sut = ErrorViewModel()

        sut.display(error)

        #expect(sut.errorMessage == expectedErrorMessage)
    }
}

enum LocalizedErrorImplementation: Error, LocalizedError {
    case someLocalizedError

    var errorDescription: String? {
        switch self {
        case .someLocalizedError:
            "Some localized error message"
        }
    }
}
