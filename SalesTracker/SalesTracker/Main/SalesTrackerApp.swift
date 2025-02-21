//
//  SalesTrackerApp.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

@main
struct SalesTrackerApp: App {
    static let httpClient = URLSessionHTTPClient(session: .shared)
    
    static let keychain = KeychainStore()
    
    var body: some Scene {
        WindowGroup {
            SalesTrackerApp.composeLoginScreen(
                successfulAuthAction: {
                    print("Successfully authenticated!")
                }
            )
        }
    }
}
