//
//  KeychainStoreTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 20/2/25.
//

import Testing
import Foundation
@testable import SalesTracker

@Suite(.serialized)
struct KeychainStoreTests {
    
    init() {
        clearKeychainFromArtifacts()
    }
    
    @Test func stores_value_on_empty_value_for_key() async throws {
        let keyValue = (key: "aKey", value: "aValue")
        let sut = makeSUT()
        
        try sut.store(keyValue.value, for: keyValue.key)
        
        assertStored(keyValue.value, for: keyValue.key)
    }
    
    @Test func overrides_value_on_existing_value_for_key() async throws {
        let aKey = "aKey"
        let value1 = "aValue1"
        let value2 = "aValue2"
        
        let sut = makeSUT()
        
        try sut.store(value1, for: aKey)
        try sut.store(value2, for: aKey)
        
        assertStored(value2, for: aKey)
    }
    
    @Test func throws_on_no_value_for_key() async throws {
        let nonExistingKey = "aKey"
        
        let sut = makeSUT()
        
        #expect(throws: KeychainError.itemNotFound) {
            try sut.retrieveValue(for: nonExistingKey)
        }
    }
    
    @Test func returns_existing_value_for_key() async throws {
        let aKey = "aKey"
        let aValue = "aValue1"
        
        let sut = makeSUT()
        
        try sut.store(aValue, for: aKey)
        
        #expect(try sut.retrieveValue(for: aKey) == aValue)
    }
    
}

extension KeychainStoreTests {
    func makeSUT() -> KeychainStore {
        return KeychainStore()
    }
    
    func assertStored(
        _ value: String,
        for key: String,
        file: String = #file,
        line: Int = #line,
        column: Int = #column
    ) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess,
           let retrievedData = result as? Data,
           let retrievedValue = String(data: retrievedData, encoding: .utf8) {
            #expect(value == retrievedValue)
        } else {
            Issue.record(
                "Expected to find value \(value) for key \(key)",
                sourceLocation: SourceLocation(
                    fileID: #fileID,
                    filePath: file,
                    line: line,
                    column: column
                )
            )
        }
    }
}
