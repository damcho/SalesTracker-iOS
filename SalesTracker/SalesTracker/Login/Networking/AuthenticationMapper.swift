//
//  AuthenticationMapper.swift
//  SalesTracker
//
//  Created by Damian Modernell on 19/2/25.
//

import Foundation

struct DecodableHTTPErrorMessage: Decodable {
    let message: String
}

struct DecodableAuthenticationResult: Decodable {
    let access_token: String

    func toAuthenticationResult() -> AuthenticationResult {
        .init(authToken: access_token)
    }
}

enum AuthenticationMapper {
    static let unauthorized = 401
    static let success = 200
    static func map(_ response: HTTPURLResponse, _ data: Data) throws -> AuthenticationResult {
        switch response.statusCode {
        case unauthorized:
            let errorData = try JSONDecoder().decode(
                DecodableHTTPErrorMessage.self,
                from: data
            )
            throw LoginError.authentication(errorData.message)
        case 400, 402 ..< 499:
            throw HTTPError.notFound
        case success:
            return try JSONDecoder().decode(DecodableAuthenticationResult.self, from: data).toAuthenticationResult()
        default:
            throw HTTPError.other
        }
    }
}
