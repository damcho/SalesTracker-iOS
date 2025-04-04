//
//  ActivityIndicatorViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

@MainActor
protocol ActivityIndicatorDisplayable {
    func displayActivityIndicator()
    func hideActivityIndicator()
}

@MainActor
final class ActivityIndicatorViewModel: ObservableObject {
    @Published var shouldDisplayAcTivityIndicator: Bool = false
}

// MARK: ActivityIndicatorDisplayable

extension ActivityIndicatorViewModel: ActivityIndicatorDisplayable {
    func displayActivityIndicator() {
        shouldDisplayAcTivityIndicator = true
    }

    func hideActivityIndicator() {
        shouldDisplayAcTivityIndicator = false
    }
}
