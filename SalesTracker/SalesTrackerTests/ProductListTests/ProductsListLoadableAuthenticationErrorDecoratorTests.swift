//
//  ProductsListLoadableAuthenticationErrorDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 27/2/25.
//

@testable import SalesTracker
import Testing

struct ProductsListLoadableAuthenticationErrorDecoratorTests {
    @Test
    func forwards_error_on_loader_error() async throws {
        let sut = makeSUT(stub: .failure(anyError))

        await #expect(throws: anyError, performing: {
            try await sut.loadProductsAndSales()
        })
    }

    @Test
    func calls_auth_error_closure_on_auth_error() async throws {
        var errorHandlerCallCount = 0
        let sut = makeSUT(
            stub: .failure(authError),
            authErrorHandler: {
                errorHandlerCallCount += 1
            }
        )

        await #expect(throws: authError, performing: {
            _ = try await sut.loadProductsAndSales()
        })

        #expect(errorHandlerCallCount == 1)
    }

    @Test
    func does_not_call_auth_error_closure_on_other_error() async throws {
        var errorHandlerCallCount = 0
        let sut = makeSUT(
            stub: .failure(anyError),
            authErrorHandler: {
                errorHandlerCallCount += 1
            }
        )

        await #expect(throws: anyError, performing: {
            _ = try await sut.loadProductsAndSales()
        })

        #expect(errorHandlerCallCount == 0)
    }

    @Test
    func forwards_result_on_successful_load() async throws {
        var errorHandlerCallCount = 0
        let expectedResult = (
            products: [aProduct.domain],
            currencyConverter: anyCurrencyCOnverter
        )
        let sut = makeSUT(
            stub: .success(expectedResult),
            authErrorHandler: {
                errorHandlerCallCount += 1
            }
        )

        let result = try await sut.loadProductsAndSales()

        #expect(result == expectedResult)
        #expect(errorHandlerCallCount == 0)
    }
}

extension ProductsListLoadableAuthenticationErrorDecoratorTests {
    func makeSUT(
        stub: Result<([Product], CurrencyConverter), Error>,
        authErrorHandler: @escaping () -> Void = {}
    )
        -> AuthenticationErrorDecorator
    {
        AuthenticationErrorDecorator(
            authErrorHandler: authErrorHandler,
            decoratee: ProductSalesLoadableStub(
                stub: stub
            )
        )
    }
}
