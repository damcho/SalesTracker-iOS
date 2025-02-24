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
        headers.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        return perform(request, for: completion)
	}
    
    func post<T: Encodable>(_ url: URL, _ body: T, completion: @escaping (HTTPResult) -> Void) -> HTTPClientTask {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let data = try? JSONEncoder().encode(body)
        request.httpBody = data

        return perform(request, for: completion)
    }
}

private extension URLSessionHTTPClient {
    func perform(_ request: URLRequest, for completion: @escaping (HTTPResult) -> Void) -> HTTPClientTask {
      
        let task = session.dataTask(with: request) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
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
