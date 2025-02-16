//
//  passwordView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct passwordView: View {
    var body: some View {
        SecureField(
            "Password",
            text: .constant("")
        )
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .border(.secondary)
        .padding()
    }
}

#Preview {
    passwordView()
}
