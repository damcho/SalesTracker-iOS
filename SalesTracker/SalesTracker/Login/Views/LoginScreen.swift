//
//  LoginScreen.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct LoginScreen: View {
    let errorView: ErrorView
    let usernameView: UsernameView
    let passwordView: PasswordView
    let activityIndicatorView: ActivityIndicatorView
    let loginButtonView: LoginButtonView
    
    var body: some View {
        VStack {
            activityIndicatorView
            usernameView
            passwordView
            errorView
            loginButtonView
        }
    }
}

#Preview {
    SalesTrackerApp.composeLoginScreen()
}
