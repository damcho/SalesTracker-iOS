//
//  LoginButtonView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct LoginButtonView: View {
    var body: some View {
        Button("Login") {}
        .buttonStyle(.bordered)
        .controlSize(.large)
        .padding()
    }
}

#Preview {
    LoginButtonView()
}
