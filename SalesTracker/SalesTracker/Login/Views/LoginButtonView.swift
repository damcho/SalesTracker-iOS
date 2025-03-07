//
//  LoginButtonView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct LoginButtonView: View {
    @StateObject var loginButtonViewModel: LoginButtonViewModel
    var body: some View {
        Button("Login") {
            loginButtonViewModel.didTapLoginAction()
        }
        .disabled(
            !loginButtonViewModel.shouldEnableLoginButton
        )
        .buttonStyle(.bordered)
        .controlSize(.large)
        .padding()
    }
}

#Preview {
    let viewModel = LoginButtonViewModel()
    viewModel.shouldEnableLoginButton = true
    return LoginButtonView(
        loginButtonViewModel: viewModel
    )
}

#Preview {
    let viewModel = LoginButtonViewModel()
    viewModel.shouldEnableLoginButton = false
    return LoginButtonView(
        loginButtonViewModel: viewModel
    )
}
