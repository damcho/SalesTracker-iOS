//
//  LoginScreenViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

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
