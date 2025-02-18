//
//  LoginButtonViewModelTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 17/2/25.
//

import Testing
@testable import SalesTracker

struct LoginButtonViewModelTests {

    @Test func performs_action_on_login_action_called() async throws {
        var loginActionCallsCount = 0
        let sut = LoginButtonViewModel()
        sut.loginAction = {
            loginActionCallsCount += 1
        }
        #expect(loginActionCallsCount == 0)

        sut.didTapLoginAction()
        
        #expect(loginActionCallsCount == 1)
    }
}
