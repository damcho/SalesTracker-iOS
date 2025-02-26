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
            let accessToken = try tokenLoadable.loadAccessToken()
            return ProductsListComposer.compose(
                with: ProductsListComposer.composeProductSalesLoader(
                    with: accessToken
                ),
                productSelection:  {_, _ in }
            )
        } catch {
            return SalesTrackerApp.composeLoginScreen(
                successfulAuthAction: {}
            )
        }
    }
}


struct NavigationFLowTests {

    @Test func loads_login_screen_on_access_token_load_failure() async throws {
        let sut = makeSUT(stub: .failure(anyError))
        
        let aView = sut.resolveInitialView()
        
        #expect(aView is LoginScreen)
    }
    
    @Test func loads_products_list_on_existing_access_token_stored() async throws {
        let sut = makeSUT(stub: .success("aToken"))
        
        let aView = sut.resolveInitialView()

        #expect(aView is ProductListView)
    }
}

extension NavigationFLowTests {
    func makeSUT(stub: Result<String, Error>) -> NavigationFLow {
        NavigationFLow(
            tokenLoadable: TokenLoadableStub(
                stub: stub
            )
        )
    }
}

struct TokenLoadableStub: TokenLoadable {
    let stub: Result<String, Error>
    func store(_ token: String) throws { }
    
    func loadAccessToken() throws -> String {
        try stub.get()
    }
}


