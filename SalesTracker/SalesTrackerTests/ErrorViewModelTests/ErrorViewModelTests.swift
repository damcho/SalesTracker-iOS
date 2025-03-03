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
    func displays_generic_message_on_non_localized_error() async throws {
        let sut = ErrorViewModel()

        sut.display(anyError)

        #expect(sut.errorMessage == "An error occurred.")
    }

    @Test
    func displays_custom_error_message_on_localized_error_implemented() async throws {
        let sut = ErrorViewModel()

        sut.display(LocalizedErrorImplementation.someLocalizedError)

        #expect(sut.errorMessage == LocalizedErrorImplementation.someLocalizedError.errorDescription)
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
