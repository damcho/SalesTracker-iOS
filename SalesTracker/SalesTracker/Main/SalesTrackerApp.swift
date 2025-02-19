//
//  SalesTrackerApp.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

@main
struct SalesTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            SalesTrackerApp.composeLoginScreen()
        }
    }
    

}

struct AuthenticableStub: Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        sleep(2)
        throw LoginError.authentication
       // return AuthenticationResult()
    }
}


