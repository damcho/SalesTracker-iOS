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
            .font(.system(.title3, design: .rounded))
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .submitLabel(.next)
    }
}

extension View {
    func loginTextfield() -> some View {
        modifier(LoginTextFieldViewModifier())
    }
}
