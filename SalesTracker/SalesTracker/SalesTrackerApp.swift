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
    
    static func composeLoginScreen() -> some View {
        let loginButtonViewModel = LoginButtonViewModel(
            loginAction: {}
        )
        let loginScreenViewModel = LoginScreenViewModel(
            LoginEnabler: loginButtonViewModel,
            authenticator: {_ in }
        )

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
