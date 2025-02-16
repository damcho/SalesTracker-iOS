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
            LoginScreen(
                errorView: ErrorView(),
                usernameView: UsernameView(
                    viewModel: TextfieldViewModel(
                        didChangeCallback: { _ in }
                    )
                ),
                passwordView: PasswordView(
                    viewModel: TextfieldViewModel(
                        didChangeCallback: {_ in }
                    )
                ),
                activityIndicatorView: ActivityIndicatorView(),
                loginButtonView: LoginButtonView()
            )
        }
    }
}
