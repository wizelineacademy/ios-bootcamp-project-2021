//
//  CacheTests.swift
//  TheMovieDbTests
//
//  Created by Ricardo Ramirez on 29/11/21.
//

import XCTest
@testable import TheMovieDb

class CacheTests: XCTestCase {
    
    var sut: Cache<String, String>!

    override func setUp() {
        super.setUp()
        sut = Cache<String, String>()
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func testInsert() {
        sut.insert("test", forKey: "test")
        XCTAssertEqual(sut.value(forKey: "test"), "test")
    }
    
    func testRemove() {
        sut.insert("test", forKey: "test")
        sut.removeValue(forKey: "test")
        XCTAssertNil(sut.value(forKey: "test"))
    }
    
    func testRemoveWithSubscript() {
        sut["test"] = "test"
        sut["test"] = nil
        XCTAssertEqual(sut["test"], nil)
    }
    
    func testInsertWithSubscript() {
        sut["test"] = "test"
        XCTAssertEqual(sut["test"], "test")
    }
    
}
