//
//  Test.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 16/2/25.
//

import Testing

final class UsernameViewModel {
    var username: String = ""
    let didChangeUsername: (String) -> Void
    
    init(didChangeUsername: @escaping (String) -> Void) {
        self.didChangeUsername = didChangeUsername
    }
}

struct UsernameViewModelTests {
    @Test func does_not_notify_username_change_on_init() throws {
        var usernameChangedCallCount = 0
        _ = makeSUT { _ in
            usernameChangedCallCount += 1
        }

        #expect(usernameChangedCallCount == 0)
    }
}

extension UsernameViewModelTests {
    func makeSUT(callback: @escaping (String) -> Void) -> UsernameViewModel {
        return UsernameViewModel(didChangeUsername: callback)
    }
}
