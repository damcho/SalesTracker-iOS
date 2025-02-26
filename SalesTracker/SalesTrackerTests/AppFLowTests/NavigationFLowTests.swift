//
//  NavigationFLowTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 26/2/25.
//

import Testing
@testable import SalesTracker
import Foundation
import SwiftUI

class NavigationFLow: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    let tokenLoadable: TokenLoadable
    
    init(tokenLoadable: TokenLoadable) {
        self.tokenLoadable = tokenLoadable
    }
    
    func resolveInitialView() -> any View {
        do {
            _ = try tokenLoadable.loadAccessToken()
            return AnyView(EmptyView())
        } catch {
            return SalesTrackerApp.composeLoginScreen(
                successfulAuthAction: {}
            )
        }
    }
}


struct NavigationFLowTests {

    @Test func loads_login_screen_on_access_token_load_failure() async throws {
        let sut = NavigationFLow(tokenLoadable: TokenLoadableStub(stub: .failure(anyError)))
        
        let aView = sut.resolveInitialView()
        
        #expect(aView is LoginScreen)
    }
}

struct TokenLoadableStub: TokenLoadable {
    let stub: Result<String, Error>
    func store(_ token: String) throws { }
    
    func loadAccessToken() throws -> String {
        try stub.get()
    }
}


