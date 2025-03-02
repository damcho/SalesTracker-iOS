//
//  Product.swift
//  SalesTracker
//
//  Created by Damian Modernell on 22/2/25.
//

import Foundation

struct Product: Equatable, Hashable {
    let id: UUID
    let name: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
