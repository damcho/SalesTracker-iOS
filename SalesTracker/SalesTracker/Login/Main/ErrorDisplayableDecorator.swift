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
}

// MARK: Authenticable

extension ErrorDisplayableDecorator: Authenticable where ObjectType == Authenticable {
    func authenticate(with credentials: LoginCredentials) async throws -> AuthenticationResult {
        do {
            errorDisplayable.removeError()
            return try await decoratee.authenticate(with: credentials)
        } catch {
            errorDisplayable.display(error)
            throw error
        }
    }
}

// MARK: ProductSalesLoadable

extension ErrorDisplayableDecorator: ProductSalesLoadable where ObjectType == ProductSalesLoadable {
    func loadProductsAndSales() async throws -> ProductsSalesInfo {
        do {
            errorDisplayable.removeError()
            return try await decoratee.loadProductsAndSales()
        } catch {
            errorDisplayable.display(error)
            throw error
        }
    }
}
