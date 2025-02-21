//
//  SalesTrackerApp+LoginExtension.swift
//  SalesTracker
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation
import SwiftUI

extension SalesTrackerApp {
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
        ActivityIndicatorAuthenticationDecorator(
            decoratee: authenticable,
            activityIndicatorDisplayable: MainThreadDispatcher(
                decoratee: activityIndicatorDisplayable
            )
        )
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
    
    static func composeLoginScreen(successfulAuthAction: @escaping () -> Void) -> some View {
        let activityIndicatorViewModel = ActivityIndicatorViewModel()
        let loginButtonViewModel = LoginButtonViewModel()
        let errorViewModel = ErrorViewModel()
        let activityIndicatorAuthenticable = composeActivityIndicator(
            for: composeErrorDisplayable(
                decoratee: TokenStoreAuthenticableDecorator(
                    decoratee: RemoteAuthenticatorHandler(
                        httpClient: SalesTrackerApp.httpClient,
                        url: Source.login.getURL(for: Source.baseURL),
                        mapper: AuthenticationMapper.map
                    ),
                    store: keychain
                ),
                with: errorViewModel
            ),
            activityIndicatorDisplayable: activityIndicatorViewModel
        )
        
        let loginScreenViewModel = composeLogin(
            with: loginButtonViewModel,
            authAction: { credentials in
                Task {
                    _ = try await activityIndicatorAuthenticable.authenticate(
                        with: credentials
                    )
                    successfulAuthAction()
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
