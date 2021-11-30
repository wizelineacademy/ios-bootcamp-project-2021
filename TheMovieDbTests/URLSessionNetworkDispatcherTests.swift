//
//  URLSessionNetworkDispatcherTests.swift
//  TheMovieDbTests
//
//  Created by Ricardo Ramirez on 29/11/21.
//

import XCTest
@testable import TheMovieDb

class URLSessionNetworkDispatcherTests: XCTestCase {
    
    var sut: URLSessionNetworkDispatcher!
    
    var session: MockUrlSession!

    override func setUp() {
        super.setUp()
        session = MockUrlSession()
        sut = URLSessionNetworkDispatcher(urlSession: session)
    }
    
    override func tearDown() {
        self.sut = nil
        self.session = nil
        super.tearDown()
    }
    
    func testErrorWithInvalidURLRequest() {
        let request = SimpleRequest(queryParams: nil, path: "{[@@€")
        let expectation = self.expectation(description: "errorWithInvalidURLRequest")
        var result: Result<Data, Error>?
        sut.dispatch(request: request) { response in
            result = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertThrowsError(try result?.get())
    }
    
    func testErrorWithRequestFailed() {
        session.dataTask.error = NSError(domain: "", code: 0, userInfo: nil)
        let request = SimpleRequest(queryParams: nil, path: "/")
        let expectation = self.expectation(description: "errorWithInvalidURLRequest")
        var result: Result<Data, Error>?
        sut.dispatch(request: request) { response in
            result = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertThrowsError(try result?.get())
    }
    
    func testErrorWithNoData() {
        let request = SimpleRequest(queryParams: nil, path: "/")
        let expectation = self.expectation(description: "errorWithInvalidURLRequest")
        var result: Result<Data, Error>?
        sut.dispatch(request: request) { response in
            result = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertThrowsError(try result?.get())
    }
}

class MockUrlSession: URLSessionProtocol {
    
    var wasCalled = false
    
    var dataTask = MockUrlSessionDataTask()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        wasCalled = true
        dataTask.completion = completionHandler
        return dataTask
    }
    
}

class MockUrlSessionDataTask: URLSessionDataTaskProtocol {
    
    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    
    var data: Data?
    
    var error: Error?
    
    func resume() {
        if let completion = completion {
            completion(data, nil, error)
        }
    }
}
