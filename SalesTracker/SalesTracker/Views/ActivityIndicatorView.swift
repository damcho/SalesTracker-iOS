//
//  ActivityIndicatorView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct ActivityIndicatorView: View {
    @StateObject var viewModel: ActivityIndicatorViewModel
    var body: some View {
        if viewModel.shouldDisplayAcTivityIndicator {
            ProgressView().controlSize(.large)
        }
    }
}

#Preview {
    let viewModel = ActivityIndicatorViewModel()
    viewModel.shouldDisplayAcTivityIndicator = true
    return ActivityIndicatorView(viewModel: viewModel)
}

#Preview {
    let viewModel = ActivityIndicatorViewModel()
    viewModel.shouldDisplayAcTivityIndicator = false
    return ActivityIndicatorView(viewModel: viewModel)
}
