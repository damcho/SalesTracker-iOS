//
//  AuthenticationErrorDecorator.swift
//  SalesTracker
//
//  Created by Damian Modernell on 27/2/25.
//

import Foundation

struct AuthenticationErrorDecorator {
    let authErrorHandler: () -> Void
    let decoratee: ProductSalesLoadable
}

// MARK: ProductSalesLoadable

extension AuthenticationErrorDecorator: ProductSalesLoadable {
    func loadProductsAndSales() async throws -> (products: [Product], currencyConverter: CurrencyConverter) {
        do {
            return try await decoratee.loadProductsAndSales()
        } catch let error as LoginError {
            if case .authentication = error {
                authErrorHandler()
            }
            throw error
        } catch {
            throw error
        }
    }
}
