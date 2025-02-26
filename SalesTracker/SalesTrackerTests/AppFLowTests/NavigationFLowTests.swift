//
//  NavigationFLowTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 26/2/25.
//

import Testing
@testable import SalesTracker
import Foundation

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


