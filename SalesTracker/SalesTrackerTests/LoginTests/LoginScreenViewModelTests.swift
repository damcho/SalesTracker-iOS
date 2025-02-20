//
//  LoginScreenViewModelTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 16/2/25.
//

import Testing
@testable import SalesTracker

final class LoginScreenViewModelTests {
    
    private var sutTracker: MemoryLeakTracker<LoginScreenViewModel>?
     
     deinit {
         sutTracker?.verify()
     }
    
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
        await confirmation { confirmation in
            let (sut, _) = makeSUT(
                authClosure: { credentials in
                    #expect(
                        credentials == anyLoginCredentials
                    )
                    confirmation()
                }
            )
            sut.simulateLoginCredentialsFilled()
            sut.didTapLogin()
        }
    }
}

extension LoginScreenViewModelTests {
    func makeSUT(
        authClosure: @escaping Authenticator = {_ in },
        filePath: String = #file,
        line: Int = #line,
        column: Int = #column
    ) -> (LoginScreenViewModel, LoginEnablerSpy) {
        let loginEnablerSpy = LoginEnablerSpy()
        let sut = SalesTrackerApp.composeLogin(
            with: loginEnablerSpy,
            authAction: authClosure
        )
        let sourceLocation = SourceLocation(fileID: #fileID, filePath: filePath, line: line, column: column)
        sutTracker = .init(instance: sut, sourceLocation: sourceLocation)

        return (sut, loginEnablerSpy)
    }
}

extension LoginScreenViewModel {
    func simulateLoginCredentialsFilled() {
        username = anyLoginCredentials.username
        password = anyLoginCredentials.password
    }
}

class LoginEnablerSpy: LoginEnabler {
    var loginAction: SalesTracker.LoginAction?
    var enableCalls: [Bool] = []
    
    func enable(_ enabled: Bool) {
        enableCalls.append(enabled)
    }
}
