//
//  KeychainStoreTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 20/2/25.
//

import Testing
import Foundation


enum KeychainError: Error {
    case itemNotFound
    case encoding
    case store
}

struct KeychainStore {
    func store(_ value: String, for key: String) throws {
        guard let valueData = value.data(using: .utf8) else {
            throw KeychainError.encoding
        }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: valueData
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            throw KeychainError.store
        }
    }
}

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
        
    }
    
    @Test func throws_on_no_value_for_key() async throws {
        
    }
    
    @Test func returns_existing_value_for_key() async throws {
        
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

func clearKeychainFromArtifacts() {
    let secItemClasses = [
        kSecClassGenericPassword,
        kSecClassInternetPassword,
        kSecClassCertificate,
        kSecClassKey,
        kSecClassIdentity
    ]
    for secItemClass in secItemClasses {
        let dictionary = [kSecClass as String: secItemClass]
        SecItemDelete(dictionary as CFDictionary)
    }
}
