//
//  HTTPHeaderTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 24/2/25.
//

@testable import SalesTracker
import Testing

struct HTTPHeaderTests {
    @Test
    func test_authorization_header() async throws {
        let aToken = "aToken"
        #expect(HTTPHeader.authorization(accessToken: aToken) == HTTPHeader(key: "Authorization", value: aToken))
    }
}
