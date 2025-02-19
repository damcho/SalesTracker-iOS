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
    
    static func composeLogin(
        with enabler: some LoginEnabler,
        authAction: @escaping Authenticator
    ) -> LoginScreenViewModel {
        let loginScreenViewModel = LoginScreenViewModel(
            loginEnabler: WeakRefVirtualProxy(enabler),
            authenticator: authAction
        )
        enabler.loginAction = loginScreenViewModel.didTapLogin
        return loginScreenViewModel
    }
    
    static func composeActivityIndicator(
        for authenticable: Authenticable,
        activityIndicatorDisplayable: ActivityIndicatorDisplayable
    ) -> Authenticable {
        let activityIndicatorAuthDecorator = ActivityIndicatorAuthenticationDecorator(
            decoratee: authenticable,
            activityIndicatorDisplayable: MainThreadDispatcher(
                decoratee: activityIndicatorDisplayable
            )
        )
        return activityIndicatorAuthDecorator
    }
    
    static func composeErrorDisplayable(
        decoratee: Authenticable,
        with errorDisplayable: ErrorDisplayable
    ) -> Authenticable {
        ErrorDisplayableAuthenticattorDecorator(
            decoratee: decoratee,
            errorDisplayable: MainThreadDispatcher(
                decoratee: errorDisplayable
            )
        )
    }
    
    static func composeLoginScreen() -> some View {
        let activityIndicatorViewModel = ActivityIndicatorViewModel()
        let loginButtonViewModel = LoginButtonViewModel()
        let errorViewModel = ErrorViewModel()
        let activityIndicatorAuthenticable = composeActivityIndicator(
            for: composeErrorDisplayable(
                decoratee: AuthenticableStub(),
                with: errorViewModel
            ),
            activityIndicatorDisplayable: activityIndicatorViewModel
        )
        let loginScreenViewModel = composeLogin(
            with: loginButtonViewModel,
            authAction: { credentials in
                Task {
                    _ = try await activityIndicatorAuthenticable.authenticate(with: credentials)
                }
            }
        )
        return LoginScreen(
            errorView: ErrorView(
                viewModel: errorViewModel
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
                viewModel: activityIndicatorViewModel
            ),
            loginButtonView: LoginButtonView(
                loginButtonViewModel: loginButtonViewModel
            )
        )
    }
}

struct AuthenticableStub: Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        sleep(2)
        throw LoginError.authentication
       // return AuthenticationResult()
    }
}


