//
//  TheMovieDbTests.swift
//  TheMovieDbTests
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import XCTest
@testable import TheMovieDb

class TheMovieDbTests: XCTestCase {
    var sut: MovieClient!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        try super.setUpWithError()
        sut = MovieClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }
     /*override func setUp() {
        <#code#>
    }*/
    func testExample() throws {
        // self.expectation(description: <#T##String#>)
        // self.waitForExpectations(timeout: 0.2)
        // XCTAssertNil(<#T##expression: Any?##Any?#>)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNetworking() {
        
    }
    
}
