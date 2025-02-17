//
//  LoginScreenViewModelTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 16/2/25.
//

import Testing
@testable import SalesTracker

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
    
    @Test func starts_authentication_with_login_credentials_on_login_tapped() async throws {
        let (sut, _) = makeSUT(
            authClosure: { credentials in
                #expect(
                    credentials == anyLoginCredentials
                )
            }
        )
        
        sut.simulateLoginCredentialsFilled()
        
        sut.didTapLogin()
    }
}

extension LoginScreenViewModelTests {
    func makeSUT(authClosure: @escaping Authenticator = {_ in }) -> (LoginScreenViewModel, LoginEnablerSpy) {
        let loginEnablerSpy = LoginEnablerSpy()
        return (
            LoginScreenViewModel(
                LoginEnabler: loginEnablerSpy,
                authenticator: authClosure
            ),
            loginEnablerSpy
        )
    }
}

extension LoginScreenViewModel {
    func simulateLoginCredentialsFilled() {
        username = anyLoginCredentials.username
        password = anyLoginCredentials.password
    }
}

class LoginEnablerSpy: LoginEnabler {
    var enableCalls: [Bool] = []
    
    func enable(_ enabled: Bool) {
        enableCalls.append(enabled)
    }
}
