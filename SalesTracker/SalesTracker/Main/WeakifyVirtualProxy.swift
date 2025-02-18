//
//  WeakifyVirtualProxy.swift
//  SalesTracker
//
//  Created by Damian Modernell on 18/2/25.
//

import Foundation

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?

    init(_ object: T) {
        self.object = object
    }
}
