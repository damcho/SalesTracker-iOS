//
//  LoginScreenViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

protocol LoginEnabler: AnyObject {
    var loginAction: LoginAction? { get set }
    func enable(_ enabled: Bool)
}

typealias Authenticator = (LoginCredentials) -> Void

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
    let authenticate: Authenticator

    init(loginEnabler: LoginEnabler, authenticator: @escaping Authenticator) {
        self.LoginEnabler = loginEnabler
        self.authenticate = authenticator
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

    func didTapLogin() {
        authenticate(
            LoginCredentials(
                username: username,
                password: password
            )
        )
    }
}
