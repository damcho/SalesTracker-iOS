//
//  Source.swift
//  SalesTracker
//
//  Created by Damian Modernell on 20/2/25.
//
import Foundation

enum Source {
    static let baseURL: URL = .init(string: "https://ile-b2p4.essentialdeveloper.com")!
    case login
    case productsList
    case salesList
    case currencyRates

    func getURL(for baseURL: URL) -> URL {
        switch self {
        case .login:
            baseURL.appendingPathComponent("login")
        case .productsList:
            baseURL.appendingPathComponent("products")
        case .salesList:
            baseURL.appendingPathComponent("sales")
        case .currencyRates:
            baseURL.appendingPathComponent("rates")
        }
    }
}
