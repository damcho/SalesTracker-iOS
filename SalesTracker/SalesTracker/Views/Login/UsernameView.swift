//
//  UsernameView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct UsernameView: View {
    @StateObject var viewModel: TextfieldViewModel
    var body: some View {
        TextField(
                "User name",
                text: $viewModel.textfieldLabel
            )
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding()
    }
}

#Preview {
    UsernameView(
        viewModel: TextfieldViewModel(
            didChangeCallback: { _ in }
        )
    )
}
