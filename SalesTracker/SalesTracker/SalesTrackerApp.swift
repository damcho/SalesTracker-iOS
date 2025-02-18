//
//  SalesTrackerApp.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

@main
struct SalesTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            SalesTrackerApp.composeLoginScreen()
        }
    }
    
    static func composeLogin(with enabler: some LoginEnabler) -> LoginScreenViewModel {
        let loginScreenViewModel = LoginScreenViewModel(
            loginEnabler: WeakRefVirtualProxy(enabler),
            authenticator: {_ in }
        )
        enabler.loginAction = loginScreenViewModel.didTapLogin
        return loginScreenViewModel
    }
    
    static func composeLoginScreen() -> some View {
        let loginButtonViewModel = LoginButtonViewModel()
        let loginScreenViewModel = composeLogin(with: loginButtonViewModel)
        return LoginScreen(
            errorView: ErrorView(
                viewModel: ErrorViewModel()
            ),
            usernameView: UsernameView(
                viewModel: TextfieldViewModel(
                    didChangeCallback: loginScreenViewModel.didEnterUsername(_:)
                )
            ),
            passwordView: PasswordView(
                viewModel: TextfieldViewModel(
                    didChangeCallback: loginScreenViewModel.didEnterPassword(_:)
                )
            ),
            activityIndicatorView: ActivityIndicatorView(
                viewModel: ActivityIndicatorViewModel()
            ),
            loginButtonView: LoginButtonView(
                loginButtonViewModel: loginButtonViewModel
            )
        )
    }
}
