//
//  LoginScreen.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct LoginScreen: View {
    let navigationTitle: String
    let activityIndicatorView: ActivityIndicatorView
    let loginButtonView: LoginButtonView
    @StateObject var loginScreenViewModel: LoginScreenViewModel

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    // Activity indicator area
                    Rectangle()
                        .fill(Color.clear)
                        .overlay {
                            activityIndicatorView
                        }
                        .frame(height: 60)

                    // Main content
                    VStack(spacing: 32) {
                        Spacer(minLength: 40)

                        // Header section
                        VStack(spacing: 16) {
                            // App icon placeholder or logo could go here
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 60))
                                .foregroundStyle(.blue.gradient)

                            Text("Welcome Back")
                                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                .foregroundColor(.primary)

                            Text("Sign in to continue")
                                .font(.system(.title3, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        .padding(.bottom, 20)

                        // Form section
                        VStack(spacing: 20) {
                            TextField(
                                "Username",
                                text: $loginScreenViewModel.username
                            )
                            .loginTextfield()

                            SecureField(
                                "Password",
                                text: $loginScreenViewModel.password
                            )
                            .loginTextfield()

                            loginButtonView
                        }
                        .padding(.horizontal, 24)

                        Spacer(minLength: 40)
                    }
                }
                .frame(minHeight: geometry.size.height)
            }
        }
        .background(
            LinearGradient(
                colors: [
                    Color(.systemBackground),
                    Color(.systemBackground).opacity(0.8)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .onAppear {
            loginScreenViewModel.onappear()
        }
        .navigationTitle(Text(navigationTitle))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LoginScreenComposer.composeLoginScreen(
        successfulAuthAction: { _ in }
    )
}
