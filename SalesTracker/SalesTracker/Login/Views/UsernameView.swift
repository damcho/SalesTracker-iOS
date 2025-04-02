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
            "Username",
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
    UsernameView(
        viewModel: TextfieldViewModel(
            didChangeCallback: { _ in }
        )
    )
}
