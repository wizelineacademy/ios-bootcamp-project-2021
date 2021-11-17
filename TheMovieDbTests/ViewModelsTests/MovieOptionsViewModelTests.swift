//
//  MovieOptionsViewModelTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 16/11/21.
//

import XCTest
@testable import TheMovieDb

class MovieOptionsViewModelTests: XCTestCase {
    
    var viewModel: MoviesOptionsViewModel?
    
    override func setUp() {
        viewModel = MoviesOptionsViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testTitle() {
        XCTAssert(viewModel?.title == "Show Movies", "Fail")
    }

    func testOptions() {
        let expectedOptions: [MoviesOptions] = [.trending, .nowPlaying, .popular, .topRated, .upcoming]
        XCTAssert(viewModel?.movieOptions == expectedOptions, "Invalid options")
    }
}
