//
//  LoginButtonViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

typealias LoginAction = () -> Void

final class LoginButtonViewModel: ObservableObject {
    @Published var shouldEnableLoginButton: Bool = false
    var loginAction: LoginAction?

    func didTapLoginAction() {
        loginAction?()
    }
}

// MARK: LoginEnabler

extension LoginButtonViewModel: LoginEnabler {
    func enable(_ enabled: Bool) {
        shouldEnableLoginButton = enabled
    }
}
