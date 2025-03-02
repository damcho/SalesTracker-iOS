//
//  MemoryLeakTracker.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 18/2/25.
//

import Foundation
import Testing

struct MemoryLeakTracker<T: AnyObject> {
    weak var instance: T?
    var sourceLocation: SourceLocation

    func verify() {
        #expect(
            instance == nil,
            "Expected \(instance) to be deallocated. Potential memory leak",
            sourceLocation: sourceLocation
        )
    }
}
