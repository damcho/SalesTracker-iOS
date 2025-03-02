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
        .textFieldStyle(.roundedBorder)
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .padding()
    }
}

#Preview {
    PasswordView(
        viewModel: TextfieldViewModel(
            didChangeCallback: { _ in }
        )
    )
}
