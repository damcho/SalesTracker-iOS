//
//  MainThreadDispatcher+extension.swift
//  SalesTracker
//
//  Created by Damian Modernell on 18/2/25.
//

import Foundation

// MARK: - MainThreadDispatcher + ActivityIndicatorDisplayable

extension MainThreadDispatcher: ActivityIndicatorDisplayable where ObjectType == ActivityIndicatorDisplayable {
    func displayActivityIndicator() {
        Task { @MainActor in
            decoratee.displayActivityIndicator()
        }
    }

    func hideActivityIndicator() {
        Task { @MainActor in
            decoratee.hideActivityIndicator()
        }
    }
}
