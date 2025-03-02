//
//  TextfieldViewModel.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import Foundation

final class TextfieldViewModel {
    var textfieldLabel: String = "" {
        didSet {
            didChangeTextfieldLabel(textfieldLabel)
        }
    }

    let didChangeTextfieldLabel: (String) -> Void

    init(didChangeCallback: @escaping (String) -> Void) {
        self.didChangeTextfieldLabel = didChangeCallback
    }
}

// MARK: ObservableObject

extension TextfieldViewModel: ObservableObject {}
