//
//  ErrorView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 12/6/25.
//

import SwiftUI

struct ErrorView: View {
    @Binding var errorText: String

    var body: some View {
        if !errorText.isEmpty {
            VStack {
                HStack {
                    Text(errorText)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(5)
                        .shadow(radius: 10)
                }.padding()
                Spacer()
            }
        }
    }
}

#Preview {
    @Previewable @State var aString = "Error Test"
    ErrorView(errorText: $aString)
}
