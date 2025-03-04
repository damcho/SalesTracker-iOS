//
//  ErrorDisplayableDecorator.swift
//  SalesTracker
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation

protocol ErrorDisplayable {
    func display(_ error: Error)
    func removeError()
}

struct ErrorDisplayableDecorator<ObjectType> {
    let decoratee: ObjectType
    let errorDisplayable: ErrorDisplayable

    func perform<R>(_ action: () async throws -> R) async throws -> R {
        do {
            errorDisplayable.removeError()
            return try await action()
        } catch {
            errorDisplayable.display(error)
            throw error
        }
    }
}

// MARK: Authenticable

extension ErrorDisplayableDecorator: Authenticable where ObjectType == Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        try await perform {
            try await decoratee.authenticate(with: credentials)
        }
    }
}

// MARK: ProductSalesLoadable

extension ErrorDisplayableDecorator: ProductSalesLoadable where ObjectType == ProductSalesLoadable {
    func loadProductsAndSales() async throws -> ProductsSalesInfo {
        try await perform {
            try await decoratee.loadProductsAndSales()
        }
    }
}
