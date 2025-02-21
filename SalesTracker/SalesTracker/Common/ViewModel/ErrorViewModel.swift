//
//  ErrorViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

final class ErrorViewModel: ObservableObject {
    @Published var errorMessage: String = ""
}

extension ErrorViewModel: ErrorDisplayable {
    func display(_ error: any Error) {
        errorMessage = error.localizedDescription
    }
}
