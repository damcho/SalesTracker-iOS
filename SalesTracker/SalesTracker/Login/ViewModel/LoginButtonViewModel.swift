//
//  LoginButtonViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

final class LoginButtonViewModel: ObservableObject {
    @Published var shouldEnableLoginButton: Bool = false
}

extension LoginButtonViewModel: LoginEnabler {
    func enable(_ enabled: Bool) {
        shouldEnableLoginButton = enabled
    }
}
