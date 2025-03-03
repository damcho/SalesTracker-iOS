//
//  ErrorViewModelTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 3/3/25.
//

@testable import SalesTracker
import Testing

struct ErrorViewModelTests {
    @Test
    func displays_generic_message_on_non_localized_error() async throws {
        let sut = ErrorViewModel()

        sut.display(anyError)

        #expect(sut.errorMessage == "An error occurred.")
    }
}
