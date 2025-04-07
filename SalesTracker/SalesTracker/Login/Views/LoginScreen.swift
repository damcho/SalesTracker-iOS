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
        VStack {
            Rectangle()
                .fill(Color.clear)
                .overlay {
                    activityIndicatorView
                }
                .frame(height: 60)
            Spacer()
            Text("Log In").font(.system(.largeTitle))

            TextField(
                "Username",
                text: $loginScreenViewModel.username
            ).loginTextfield()

            SecureField(
                "Password",
                text: $loginScreenViewModel.password
            ).loginTextfield()

            loginButtonView
            Spacer()
        }
        .onAppear {
            loginScreenViewModel.onappear()
        }
        .navigationTitle(Text(navigationTitle))
    }
}

#Preview {
    LoginScreenComposer.composeLoginScreen(
        successfulAuthAction: { _ in }
    )
}
