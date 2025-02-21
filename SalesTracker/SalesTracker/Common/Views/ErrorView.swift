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
        Text(viewModel.errorMessage)
            .foregroundStyle(.red)
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
    errorViewModel.errorMessage = "some error"
    return errorView
}
