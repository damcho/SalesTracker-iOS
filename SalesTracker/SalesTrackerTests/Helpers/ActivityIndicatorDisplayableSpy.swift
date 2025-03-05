//
//  ActivityIndicatorDisplayableSpy.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 5/3/25.
//

import Foundation
@testable import SalesTracker

final class activityIndicatorDisplayableSpy: ActivityIndicatorDisplayable {
    var activityIndicatorMessages: [Bool] = []
    var isMainThread = false
    func displayActivityIndicator() {
        activityIndicatorMessages.append(true)
        isMainThread = Thread.isMainThread
    }

    func hideActivityIndicator() {
        activityIndicatorMessages.append(false)
        isMainThread = Thread.isMainThread
    }
}
