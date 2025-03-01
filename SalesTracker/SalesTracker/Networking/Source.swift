//
//  Source.swift
//  SalesTracker
//
//  Created by Damian Modernell on 20/2/25.
//
import Foundation

enum Source {
    static let baseURL: URL = URL(string: "https://ile-b2p4.essentialdeveloper.com")!
    case login
    case productsList
    case salesList
    case currencyRates
    
    func getURL(for baseURL: URL) -> URL {
        switch self {
        case .login:
            return baseURL.appendingPathComponent("login")
        case .productsList:
            return baseURL.appendingPathComponent("products")
        case .salesList:
            return baseURL.appendingPathComponent("sales")
        case .currencyRates:
            return baseURL.appendingPathComponent("rates")
        }
    }
}
