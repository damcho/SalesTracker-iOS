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
	
	public func get(from url: URL, completion: @escaping (HTTPResult) -> Void) -> HTTPClientTask {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return perform(request, for: completion)
	}
}

extension URLSessionHTTPClient {
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
