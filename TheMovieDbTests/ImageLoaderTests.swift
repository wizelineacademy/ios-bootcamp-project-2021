//
//  ImageLoaderTests.swift
//  TheMovieDbTests
//
//  Created by Ricardo Ramirez on 30/11/21.
//

import XCTest
@testable import TheMovieDb

class ImageLoaderTests: XCTestCase {
    
    var cache: Cache<String, UIImage>!
    
    var sut: ImageLoader!
    
    var session: MockUrlSession!

    override func setUp() {
        super.setUp()
        session = MockUrlSession()
        cache = Cache<String, UIImage>()
        sut = ImageLoader(urlSession: session, cache: cache)
    }
    
    override func tearDown() {
        self.sut = nil
        self.session = nil
        self.cache = nil
        super.tearDown()
    }
    
    func testLoadingImageWhenCached() {
        cache["https://www.google.com/"] = UIImage()
        let expectation = self.expectation(description: "loadingImageWhenCached")
        var result: UIImage?
        sut.getImage(withURL: URL(string: "https://www.google.com/")!) { image in
            result = image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(result)
    }
    
    func testNilAfterErrorRequest() {
        let expectation = self.expectation(description: "loadingImageWhenCached")
        var result: UIImage?
        sut.getImage(withURL: URL(string: "https://www.google.com/")!) { image in
            result = image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNil(result)
    }
}
