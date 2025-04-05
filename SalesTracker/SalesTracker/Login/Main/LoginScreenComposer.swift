//
//  LoginScreenComposer.swift
//  SalesTracker
//
//  Created by Damian Modernell on 27/2/25.
//

import Foundation
import SwiftUI

enum LoginScreenComposer {
    static func composeLogin(
        with enabler: some LoginEnabler,
        authAction: @escaping Authenticator
    )
        -> LoginScreenViewModel
    {
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
    )
        -> Authenticable
    {
        ActivityIndicatorAuthenticationDecorator(
            decoratee: authenticable,
            activityIndicatorDisplayable: activityIndicatorDisplayable
        )
    }

    static func composeErrorDisplayable(
        decoratee: Authenticable,
        with errorDisplayable: ErrorDisplayable
    )
        -> Authenticable
    {
        ErrorDisplayableDecorator(
            decoratee: decoratee,
            errorDisplayable: errorDisplayable
        )
    }

    @MainActor
    static func composeLogin() -> (LoginButtonViewModel, ActivityIndicatorViewModel, ErrorViewModel, Authenticable) {
        let activityIndicatorViewModel = ActivityIndicatorViewModel()
        let loginButtonViewModel = LoginButtonViewModel()
        let errorViewModel = ErrorViewModel(dismisErrorAction: {})
        let activityIndicatorAuthenticable = composeActivityIndicator(
            for: composeErrorDisplayable(
                decoratee: TokenStoreAuthenticableDecorator(
                    decoratee: RemoteAuthenticatorHandler(
                        httpClient: SalesTrackerApp.httpClient,
                        url: Source.login.getURL(for: Source.baseURL),
                        mapper: AuthenticationMapper.map
                    ),
                    store: SalesTrackerApp.keychain
                ),
                with: errorViewModel
            ),
            activityIndicatorDisplayable: activityIndicatorViewModel
        )
        return (loginButtonViewModel, activityIndicatorViewModel, errorViewModel, activityIndicatorAuthenticable)
    }

    @MainActor
    static func composeLoginScreen(successfulAuthAction: @escaping (String) -> Void) -> any View {
        let (
            loginButtonViewModel,
            activityIndicatorViewModel,
            errorViewModel,
            activityIndicatorAuthenticable
        ) = composeLogin()
        let loginScreenViewModel = composeLogin(
            with: loginButtonViewModel,
            authAction: { credentials in
                Task {
                    let response = try await activityIndicatorAuthenticable.authenticate(
                        with: credentials
                    )
                    successfulAuthAction(response.authToken)
                }
            }
        )
        return LoginScreen(
            navigationTitle: "Sales Tracker",
            activityIndicatorView: ActivityIndicatorView(
                viewModel: activityIndicatorViewModel
            ),
            loginButtonView: LoginButtonView(
                loginButtonViewModel: loginButtonViewModel
            ),
            loginScreenViewModel: loginScreenViewModel
        ).withErrorHandler(errorViewModel)
    }
}
