//
//  KeychainStore.swift
//  SalesTracker
//
//  Created by Damian Modernell on 21/2/25.
//

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

        remove(valueFor: key)

        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else {
            throw KeychainError.store
        }
    }

    func retrieveValue(for key: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var result: AnyObject?

        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard
            status == errSecSuccess,
            let retrievedData = result as? Data,
            let retrievedValue = String(data: retrievedData, encoding: .utf8)
        else {
            throw KeychainError.itemNotFound
        }
        return retrievedValue
    }

    func remove(valueFor key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]

        SecItemDelete(query as CFDictionary)
    }
}

// MARK: TokenStore

extension KeychainStore: TokenStore {
    var authTokenStoreKey: String {
        "authTokenKey"
    }

    func store(_ token: String) throws {
        try store(token, for: authTokenStoreKey)
    }
}

// MARK: TokenLoadable

extension KeychainStore: TokenLoadable {
    func loadAccessToken() throws -> String {
        try retrieveValue(for: authTokenStoreKey)
    }
}
