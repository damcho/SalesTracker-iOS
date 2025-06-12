//
//  ErrorDisplayableDecorator.swift
//  SalesTracker
//
//  Created by Damian Modernell on 1/4/25.
//

@MainActor
protocol ErrorDisplayable {
    func display(_ error: SalesTrackerError)
}

typealias ActionType<Obj> = () async throws -> Obj

struct ErrorDisplayableDecorator<ObjectType> {
    let decoratee: ObjectType
    let errorDisplayable: ErrorDisplayable

    func perform<R>(_ action: ActionType<R>) async throws -> R {
        do {
            return try await action()
        } catch let error as SalesTrackerError {
            await errorDisplayable.display(error)
            throw error
        } catch {
            await errorDisplayable.display(SalesTrackerError.other(error.localizedDescription))
            throw error
        }
    }
}
