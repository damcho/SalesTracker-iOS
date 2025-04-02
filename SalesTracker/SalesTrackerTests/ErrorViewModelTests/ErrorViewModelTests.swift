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
        await expect(
            LocalizedErrorImplementation.someLocalizedError.errorDescription!,
            for: LocalizedErrorImplementation.someLocalizedError
        )
        await expect(
            "An error occurred.",
            for: anyError
        )
    }

    @Test
    func displays_empty_string_on_remove_error_called() async throws {
        let sut = await ErrorViewModel()

        await sut.removeError()

        #expect(await sut.errorMessage == "")
    }

    func expect(_ expectedErrorMessage: String, for error: Error) async {
        let sut = await ErrorViewModel()

        await sut.display(error)

        #expect(await sut.errorMessage == expectedErrorMessage)
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
