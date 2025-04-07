//
//  LoginTextFieldViewModifier.swift
//  SalesTracker
//
//  Created by Damian Modernell on 4/4/25.
//

import Foundation
import SwiftUI

struct LoginTextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title))
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding()
    }
}

extension View {
    func loginTextfield() -> some View {
        modifier(LoginTextFieldViewModifier())
    }
}
