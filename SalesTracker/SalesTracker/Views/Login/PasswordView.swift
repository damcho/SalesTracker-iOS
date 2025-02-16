//
//  passwordView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct PasswordView: View {
    var body: some View {
        SecureField(
            "Password",
            text: .constant("")
        )
        .textFieldStyle(.roundedBorder)
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .padding()
    }
}

#Preview {
    PasswordView()
}
