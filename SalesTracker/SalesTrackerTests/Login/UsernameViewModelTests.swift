//
//  Test.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 16/2/25.
//

import Testing

final class UsernameViewModel {
    var username: String = "" {
        didSet {
            didChangeUsername(username)
        }
    }
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
    
    @Test func notifies_username_text_changed() throws {
        var username = ""
        let sut = makeSUT { newUsername in
            username = newUsername
        }
        
        sut.username = "t"

        #expect(username == "t")
        
        sut.username = "te"

        #expect(username == "te")
    }
}

extension UsernameViewModelTests {
    func makeSUT(callback: @escaping (String) -> Void) -> UsernameViewModel {
        return UsernameViewModel(didChangeUsername: callback)
    }
}
