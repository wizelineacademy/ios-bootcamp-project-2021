//
//  MovieListViewModelTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 16/11/21.
//

import XCTest
@testable import TheMovieDb

class MovieListViewModelTests: XCTestCase {
    
    var viewModel: MovieListViewModel?

    override func setUp() {
        viewModel = MovieListViewModel(facade: MockService())
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testGetMovies() {
        viewModel?.loadMovies()
        
        XCTAssertTrue(viewModel?.movies.count == 4, "No movies")
    }
    
    func testListOption() {
        XCTAssert(viewModel?.movieListOption == .nowPlaying, "Wrong list option")
    }
    
    func testMovieReturned() {
        viewModel?.loadMovies()
        guard let movie = viewModel?.movies[0] else {
            XCTFail("No movie")
            return
        }
        
        XCTAssert(movie.title == "Dune", "Wrong movie returned")
    }
    
    func testTitle() {
        viewModel?.movieListOption = .nowPlaying
        XCTAssert(viewModel?.movieListOption.title == "Now Playing", "Failure")
    }
}
