//
//  ErrorDisplayableDecorator.swift
//  SalesTracker
//
//  Created by Damian Modernell on 1/4/25.
//

@MainActor
protocol ErrorDisplayable {
    func display(_ error: Error)
    func removeError()
}

struct ErrorDisplayableDecorator<ObjectType> {
    let decoratee: ObjectType
    let errorDisplayable: ErrorDisplayable

    func perform<R>(_ action: () async throws -> R) async throws -> R {
        do {
            await errorDisplayable.removeError()
            return try await action()
        } catch {
            await errorDisplayable.display(error)
            throw error
        }
    }
}
