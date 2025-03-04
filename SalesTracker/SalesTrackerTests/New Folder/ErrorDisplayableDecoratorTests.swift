//
//  ErrorDisplayableDecoratorTests.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 4/3/25.
//

@testable import SalesTracker
import Testing

struct ErrorDisplayableDecoratorTests {
    @Test
    func displays_error_and_throws_on_action_failure() async throws {
        let (sut, errorDisplayableSpy) = makeSUT()

        await #expect(throws: anyError, performing: {
            try await sut.perform {
                throw anyError
            }
        })

        #expect(errorDisplayableSpy.errorDisplayMessages == [.hidesError, .displayedError])
    }

    @Test
    func hides_error_on_successfulAction() async throws {
        let (sut, errorDisplayableSpy) = makeSUT()

        _ = try await sut.perform {
            "some string"
        }

        #expect(errorDisplayableSpy.errorDisplayMessages == [.hidesError])
    }
}

extension ErrorDisplayableDecoratorTests {
    func makeSUT()
        -> (ErrorDisplayableDecorator<Encodable>, ErrorDisplayableSpy)
    {
        let spy = ErrorDisplayableSpy()
        return (
            ErrorDisplayableDecorator(
                decoratee: "some string",
                errorDisplayable: spy
            ),
            spy
        )
    }
}
