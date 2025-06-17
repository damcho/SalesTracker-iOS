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
    func displays_alert_on_auth_error() async throws {
        let sut = await makeSUT()

        await sut.display(SalesTrackerError.authentication("invalid token"))

        #expect(await sut.shouldDisplayAlert == true)
    }

    @Test
    func does_not_display_alert_on_other_error() async throws {
        let sut = await makeSUT()

        await sut.display(SalesTrackerError.other("other error"))

        #expect(await sut.shouldDisplayAlert == false)
    }

    @Test
    func empty_error_message_on_dismissed_error() async throws {
        let sut = await makeSUT()
        await sut.display(SalesTrackerError.authentication("invalid token"))

        await sut.dismiss()

        await #expect(sut.errorMessage.isEmpty)
        await #expect(sut.shouldDisplayAlert == false)
    }

    @Test
    func calls_dismiss_action_on_dismissed_error() async throws {
        var didCallDismissAction = false
        let sut = await makeSUT(dismissAction: {
            didCallDismissAction = true
        })

        await sut.dismiss()

        #expect(didCallDismissAction == true)
    }
}

extension ErrorViewModelTests {
    @MainActor
    func makeSUT(dismissAction: (() -> Void)? = nil) -> ErrorViewModel {
        .init(dismisErrorAction: dismissAction)
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
