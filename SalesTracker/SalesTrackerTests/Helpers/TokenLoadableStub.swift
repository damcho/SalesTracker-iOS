//
//  TokenLoadableStub.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 5/3/25.
//

import Foundation
@testable import SalesTracker

struct TokenLoadableStub: TokenLoadable {
    let stub: Result<String, Error>
    func store(_: String) throws {}

    func loadAccessToken() throws -> String {
        try stub.get()
    }
}
