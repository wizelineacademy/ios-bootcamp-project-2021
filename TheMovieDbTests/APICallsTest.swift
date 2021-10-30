//
//  APICallsTest.swift
//  TheMovieDbTests
//
//  Created by Javier Cueto on 27/10/21.
//

import XCTest
@testable import TheMovieDb

class APICallsTest: XCTestCase {
    
    func testCallGetTrending () throws {
        
        // 1. Define an expectation
        let expectation = expectation(description: "SomeService does stuff and runs the callback closure")
        
        // 2. Exercise the asynchronous code
        MovieAPI.shared.getReviews { movies in
            print(movies as Any)
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
}
