//
//  TextfieldViewModelTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 16/2/25.
//

@testable import SalesTracker
import Testing

struct TextfieldViewModelTests {
    @Test
    func does_not_notify_username_change_on_init() throws {
        var usernameChangedCallCount = 0
        _ = makeSUT { _ in
            usernameChangedCallCount += 1
        }

        #expect(usernameChangedCallCount == 0)
    }

    @Test
    func notifies_username_text_changed() throws {
        var username = ""
        let sut = makeSUT { newUsername in
            username = newUsername
        }

        sut.textfieldLabel = "t"

        #expect(username == "t")

        sut.textfieldLabel = "te"

        #expect(username == "te")
    }
}

extension TextfieldViewModelTests {
    func makeSUT(callback: @escaping (String) -> Void) -> TextfieldViewModel {
        TextfieldViewModel(didChangeCallback: callback)
    }
}
