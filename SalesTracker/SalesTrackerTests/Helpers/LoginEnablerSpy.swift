//
//  LoginEnablerSpy.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 5/3/25.
//

import Foundation
@testable import SalesTracker

class LoginEnablerSpy: LoginEnabler {
    var loginAction: SalesTracker.LoginAction?
    var enableCalls: [Bool] = []

    func enable(_ enabled: Bool) {
        enableCalls.append(enabled)
    }
}
