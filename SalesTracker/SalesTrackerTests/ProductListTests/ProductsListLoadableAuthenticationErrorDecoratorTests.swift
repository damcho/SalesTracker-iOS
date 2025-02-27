//
//  ProductsListLoadableAuthenticationErrorDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 27/2/25.
//

import Testing
@testable import SalesTracker

struct AuthenticationErrorDecorator {
    let authErrorHandler: () -> Void
    let decoratee: ProductSalesLoadable
}

extension AuthenticationErrorDecorator: ProductSalesLoadable {
    func loadProductsAndSales() async throws -> [Product : [Sale]] {
        authErrorHandler()
        return try await decoratee.loadProductsAndSales()
    }
}

struct ProductsListLoadableAuthenticationErrorDecoratorTests {
    
    @Test func forwards_error_on_loader_error() async throws {
        let sut = makeSUT(stub: .failure(anyError))
        
        await #expect(throws: anyError, performing: {
            try await sut.loadProductsAndSales()
        })
    }
    
    @Test func calls_auth_error_closure_on_auth_error() async throws {
        var errorHandlerCallCount = 0
        let sut = makeSUT(
            stub: .failure(authError),
            authErrorHandler: {
                errorHandlerCallCount += 1
            }
        )
        
        await #expect(throws: authError, performing: {
            _ = try await sut.loadProductsAndSales()
            #expect(errorHandlerCallCount == 1)
        })
    }
}

extension ProductsListLoadableAuthenticationErrorDecoratorTests {
    func makeSUT(
        stub: Result<[Product : [Sale]], Error>,
        authErrorHandler: @escaping () -> Void = {}
    ) -> AuthenticationErrorDecorator {
        return AuthenticationErrorDecorator(
            authErrorHandler: authErrorHandler,
            decoratee: ProductSalesLoadableStub(
                stub: stub
            )
        )
    }
}
