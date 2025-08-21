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
        Button(action: {
            loginButtonViewModel.didTapLoginAction()
        }) {
            HStack {
                Spacer()
                Text("Sign In")
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        loginButtonViewModel.shouldEnableLoginButton
                            ? LinearGradient(
                                colors: [.blue, .blue.opacity(0.8)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            : LinearGradient(
                                colors: [Color(.systemGray4), Color(.systemGray5)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                    )
                    .shadow(
                        color: loginButtonViewModel.shouldEnableLoginButton
                            ? .blue.opacity(0.3)
                            : .clear,
                        radius: 8,
                        x: 0,
                        y: 4
                    )
            )
        }
        .disabled(!loginButtonViewModel.shouldEnableLoginButton)
        .scaleEffect(loginButtonViewModel.shouldEnableLoginButton ? 1.0 : 0.98)
        .animation(.easeInOut(duration: 0.2), value: loginButtonViewModel.shouldEnableLoginButton)
        .padding(.top, 8)
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
