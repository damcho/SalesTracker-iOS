//
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

class URLProtocolStub: URLProtocol {
    private struct Stub {
        let onStartLoading: (URLProtocolStub) -> Void
    }

    private static var _stub: Stub?
    private static var stub: Stub? {
        get { queue.sync { _stub } }
        set { queue.sync { _stub = newValue } }
    }

    private static let queue = DispatchQueue(label: "URLProtocolStub.queue")

    static func stub(data: Data?, response: URLResponse?, error: Error?) {
        stub = Stub(onStartLoading: { urlProtocol in
            guard let client = urlProtocol.client else { return }

            if let data {
                client.urlProtocol(urlProtocol, didLoad: data)
            }

            if let response {
                client.urlProtocol(urlProtocol, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let error {
                client.urlProtocol(urlProtocol, didFailWithError: error)
            } else {
                client.urlProtocolDidFinishLoading(urlProtocol)
            }
        })
    }

    static func observeRequests(observer: @escaping (URLRequest) -> Void) {
        stub = Stub(onStartLoading: { urlProtocol in
            urlProtocol.client?.urlProtocolDidFinishLoading(urlProtocol)

            observer(urlProtocol.request)
        })
    }

    static func onStartLoading(observer: @escaping () -> Void) {
        stub = Stub(onStartLoading: { _ in observer() })
    }

    static func removeStub() {
        stub = nil
    }

    override class func canInit(with _: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        URLProtocolStub.stub?.onStartLoading(self)
    }

    override func stopLoading() {}
}

extension URLRequest {
    func bodySteamAsJSON() -> Any? {
        guard let bodyStream = httpBodyStream else { return nil }

        bodyStream.open()

        // Will read 16 chars per iteration. Can use bigger buffer if needed
        let bufferSize = 16

        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)

        var dat = Data()

        while bodyStream.hasBytesAvailable {
            let readDat = bodyStream.read(buffer, maxLength: bufferSize)
            dat.append(buffer, count: readDat)
        }

        buffer.deallocate()

        bodyStream.close()

        do {
            return try JSONSerialization.jsonObject(with: dat, options: JSONSerialization.ReadingOptions.allowFragments)
        } catch {
            print(error.localizedDescription)

            return nil
        }
    }
}
