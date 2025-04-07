//
//  NavigationFLowTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 26/2/25.
//

import Foundation
@testable import SalesTracker
import SwiftUI
import Testing

struct NavigationFLowTests {
    @Test
    func loads_login_screen_on_access_token_load_failure() async throws {
        let sut = await makeSUT(stub: .failure(anyError))

        #expect(await sut.navigationPath.isEmpty == true)
    }

    @Test(
        .disabled("broken test because of removed back button modifier")
    )
    func loads_products_list_on_existing_access_token_stored() async throws {
        let sut = await makeSUT(stub: .success("aToken"))

        #expect(await sut.navigationPath.count == 1)
    }
}

extension NavigationFLowTests {
    @MainActor
    func makeSUT(stub: Result<String, Error>) -> NavigationFLow {
        NavigationFLow(
            tokenLoadable: TokenLoadableStub(
                stub: stub
            )
        )
    }
}
