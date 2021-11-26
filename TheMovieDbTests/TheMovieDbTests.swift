//
//  TheMovieDbTests.swift
//  TheMovieDbTests
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import XCTest
@testable import TheMovieDb

class TheMovieDbTests: XCTestCase {
    
    var mockAPIClient: MockAPIClient!
    var movieModel: MovieModel!

    override func setUp() {
        mockAPIClient = MockAPIClient()
        let movieApiManager = MovieAPIManager(client: mockAPIClient)
        movieModel = MovieModel(movieManager: movieApiManager)
    }
    
    func testGetListSuccess() {
        movieModel.getList(movieFeed: MovieFeed.trending) { list in
            XCTAssertTrue(!list.isEmpty, "List shouldn't be empty")
        }
    }
    
    func testGetListError() {
        mockAPIClient.error = .responseUnsuccessful
        movieModel.getList(movieFeed: MovieFeed.trending) { list in
            XCTAssertTrue(list.isEmpty, "List should be empty")
        }
    }
}
