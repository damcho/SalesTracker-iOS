//
//  Copyright © Essential Developer. All rights reserved.
//

import Foundation

typealias HTTPResult = Result<(Data, HTTPURLResponse), Error>

protocol HTTPClientTask {
    func cancel()
}

final class URLSessionHTTPClient {
    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    private struct UnexpectedValuesRepresentation: Error {}

    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask

        func cancel() {
            wrapped.cancel()
        }
    }

    func get(from url: URL, headers: [HTTPHeader] = [], completion: @escaping (HTTPResult) -> Void) -> HTTPClientTask {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        return perform(request, for: completion)
    }

    func post(
        _ url: URL,
        _ body: some Encodable,
        headers: [HTTPHeader] = [],
        completion: @escaping (HTTPResult) -> Void
    )
        -> HTTPClientTask
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        let data = try? JSONEncoder().encode(body)
        request.httpBody = data

        return perform(request, for: completion)
    }
}

private extension URLSessionHTTPClient {
    func perform(_ request: URLRequest, for completion: @escaping (HTTPResult) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: request) { data, response, error in
            completion(Result {
                if let error {
                    throw error
                } else if let data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
}
