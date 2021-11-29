//
//  MovieDBAPITests.swift
//  TheMovieDbTests
//
//  Created by Ricardo Ramirez on 28/11/21.
//

import Foundation
import XCTest
@testable import TheMovieDb

class MovieDBAPITests: XCTestCase {
    
    var sut: MovieDBAPI!
    
    var networkDispatcher: MockNetworkDispatcher!

    override func setUp() {
        super.setUp()
        networkDispatcher = MockNetworkDispatcher()
        sut = MovieDBAPI(dispatcher: networkDispatcher)
    }
    
    override func tearDown() {
        sut = nil
        networkDispatcher = nil
        super.tearDown()
    }
    
    func testSuccessExecuteWithCorrectData() {
        networkDispatcher.data = """
            {
                "test_int": 0
            }
        """.data(using: .utf8)
        
        let expectation = self.expectation(description: "successExecute")
        var result: Int?
        sut.execute(SimpleRequest()) { response in
            switch response {
            case .success(let response):
                result = response.testInt
            default:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(result, 0)
    }
    
    func testSuccessExecuteWithIncorrectData() {
        networkDispatcher.data = """
            {
                "testint": 0
            }
        """.data(using: .utf8)
        
        let expectation = self.expectation(description: "successExecute")
        var result: Error?
        sut.execute(SimpleRequest()) { response in
            switch response {
            case .failure(let error):
                result = error
            default:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(result as? NetworkError)
    }
    
    func testFailureExecute() {
        networkDispatcher.error = NetworkError.invalidRequest
        
        let expectation = self.expectation(description: "failureExecute")
        var result: Error?
        sut.execute(SimpleRequest()) { response in
            switch response {
            case .failure(let error):
                result = error
            default:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(result as? NetworkError)
    }
    
    func testGetRelatedMovies() {
        networkDispatcher.data = """
            {
                "page": 1,
                "results": [
                  {
                    "id": 299536,
                    "overview": "As the Avengers...",
                    "poster_path": "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
                    "release_date": "2018-04-25",
                    "title": "Avengers: Infinity War",
                  }
                ],
                "total_pages": 792,
                "total_results": 15831
              }
        """.data(using: .utf8)
        
        let expectation = self.expectation(description: "getRelatedMovies")
        var result: MovieDBAPIListResponse<Movie>?
        sut.getRelatedMovies(
            for: MovieStubGenerator.generateMovie(),
               on: .recommendation
        ) { response in
            switch response {
            case .success(let response):
                result = response
            default:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(result?.page, 1)
        XCTAssertEqual(result?.totalPages, 792)
        XCTAssertEqual(result?.totalResults, 15831)
        XCTAssertEqual(result?.results.count, 1)
    }
    
    func testGetMovieCast() {
        networkDispatcher.data = """
            {
                "cast": [
                    {
                        "name": "Matt Damon",
                        "character": "Tristan Ludlow"
                    }
                ],
                "id": 287
              }
        """.data(using: .utf8)
        
        let expectation = self.expectation(description: "getMovieCast")
        var result: MovieCastResponse?
        sut.getMovieCast(for: MovieStubGenerator.generateMovie()) { response in
            switch response {
            case .success(let response):
                result = response
            default:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(result?.cast.count, 1)
        XCTAssertEqual(result?.id, 287)
    }
    
    func testGetMovieReviews() {
        networkDispatcher.data = """
            {
                "id": 11,
                "page": 1,
                "results": [
                  {
                    "author": "Cat Ellington",
                    "content": "Great",
                    "id": "58a231c5925141179e000674",
                  }
                ],
                "total_pages": 1,
                "total_results": 3
              }
        """.data(using: .utf8)
        let expectation = self.expectation(description: "getMovieReviews")
        var result: MovieDBAPIListResponse<Review>?
        sut.getMoviewReviews(for: MovieStubGenerator.generateMovie(), page: 1) { response in
            switch response {
            case .success(let response):
                result = response
            default:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(result?.results.count, 1)
        XCTAssertEqual(result?.page, 1)
    }
    
}
