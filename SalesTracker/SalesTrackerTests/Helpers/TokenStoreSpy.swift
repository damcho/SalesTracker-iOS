//
//  TokenStoreSpy.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 5/3/25.
//

import Foundation
@testable import SalesTracker

final class TokenStoreSpy: TokenStore {
    var stubResult: Result<Void, Error>?
    var storeMesages: [String] = []
    func store(_ token: String) throws {
        storeMesages.append(token)
        try stubResult?.get()
    }
}
