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
                usernameView: UsernameView(),
                passwordView: PasswordView(),
                activityIndicatorView: ActivityIndicatorView(),
                loginButtonView: LoginButtonView()
            )
        }
    }
}
