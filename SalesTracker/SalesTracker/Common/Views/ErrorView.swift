//
//  ErrorView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct ErrorView: View {
    @StateObject var viewModel: ErrorViewModel
    var body: some View {
        if viewModel.errorMessage.isEmpty {
            EmptyView()
        } else {
            Text(viewModel.errorMessage)
                .secondaryListText()
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    ErrorView(
        viewModel: ErrorViewModel()
    )
}

#Preview {
    let errorViewModel = ErrorViewModel()
    let errorView = ErrorView(
        viewModel: errorViewModel
    )
    errorViewModel.display(LoginError.connectivity)
    return errorView
}
