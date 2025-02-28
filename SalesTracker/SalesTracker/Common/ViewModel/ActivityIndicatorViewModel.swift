//
//  ActivityIndicatorViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

final class ActivityIndicatorViewModel: ObservableObject {
    @Published var shouldDisplayAcTivityIndicator: Bool = false
}

extension ActivityIndicatorViewModel: ActivityIndicatorDisplayable {
    func displayActivityIndicator() {
        shouldDisplayAcTivityIndicator = true
    }
    
    func hideActivityIndicator() {
        shouldDisplayAcTivityIndicator = false
    }
}
