//
//  UsernameView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct UsernameView: View {
    @State private var username: String = ""
    var body: some View {
        TextField(
                "User name",
                text: $username
            )
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding()
    }
}

#Preview {
    UsernameView()
}
