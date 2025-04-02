//
//  PasswordView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct PasswordView: View {
    @StateObject var viewModel: TextfieldViewModel

    var body: some View {
        SecureField(
            "Password",
            text: $viewModel.textfieldLabel
        )
        .font(.system(.title))
        .textFieldStyle(.roundedBorder)
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    PasswordView(
        viewModel: TextfieldViewModel(
            didChangeCallback: { _ in }
        )
    )
}
