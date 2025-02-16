//
//  LoginScreenViewModelTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 16/2/25.
//

import Testing
@testable import SalesTracker

protocol LoginEnabler {
    func enable(_ enabled: Bool)
}

final class LoginScreenViewModel {
    var username: String = "" {
        didSet {
            shouldEnableLogin()
        }
    }
    var password: String = "" {
        didSet {
            shouldEnableLogin()
        }
    }
    let LoginEnabler: LoginEnabler
    
    init(LoginEnabler: LoginEnabler) {
        self.LoginEnabler = LoginEnabler
    }
    
    func didEnterUsername(_ newUsername: String) {
        username = newUsername
    }
    
    func didEnterPassword(_ newPassword: String) {
        password = newPassword
    }
    
    func shouldEnableLogin() {
        LoginEnabler.enable(!username.isEmpty && !password.isEmpty)
    }
}

struct LoginScreenViewModelTests {
    
    @Test func enables_login_button_on_populated_username_and_password() async throws {
        let (sut, spy) = makeSUT()
        #expect(spy.enableCalls == [])

        sut.didEnterUsername("aUsername")
        #expect(spy.enableCalls == [false])
        
        sut.didEnterPassword("aPassword")
        #expect(spy.enableCalls == [false, true])
        
        sut.didEnterUsername("")
        #expect(spy.enableCalls == [false, true, false])
    }
}

extension LoginScreenViewModelTests {
    func makeSUT() -> (LoginScreenViewModel, LoginEnablerSpy) {
        let spy = LoginEnablerSpy()
        return (
            LoginScreenViewModel(
                LoginEnabler: spy
            ),
            spy
        )
    }
}

class LoginEnablerSpy: LoginEnabler {
    var enableCalls: [Bool] = []
    
    func enable(_ enabled: Bool) {
        enableCalls.append(enabled)
    }
}
