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

    @StateObject var navigation = NavigationFLow(tokenLoadable: keychain)

    var body: some Scene {
        WindowGroup {
            NavigationStack(
                path: $navigation.navigationPath,
                root: {
                    AnyView(navigation.resolveInitialScreen())
                        .navigationDestination(
                            for: Screen.self,
                            destination: { screen in
                                AnyView(navigation.destinations(for: screen))
                            }
                        )
                }
            )
        }
    }
}
