//
//  MovieListPresenterTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 23/11/21.
//

import XCTest
@testable import TheMovieDb

class MovieListPresenterTests: XCTestCase {

    var presenter: MovieListPresenter?
    var mockView = MockMovieListView()
    var facade = MockService()
    var movieListOption: MoviesOptions = .trending
    
    override func setUp() {
        presenter = MovieListPresenter(view: mockView, facade: facade, movieOption: movieListOption)
    }
    
    override func tearDown() {
        presenter = nil
    }
    
    func testMovieOptionDidSet() {
        let expectation = XCTestExpectation(description: "All options tested")
        expectation.expectedFulfillmentCount = 5
        MoviesOptions.allCases.forEach { option in
            presenter?.movieListOption = option
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(mockView.updateMoviesCalled, "Option was not setted")
        XCTAssertTrue(mockView.setTitleCalled, "Set title was not called")
    }
    
    func testShowError() {
        facade.failure = true
        presenter?.listMovies()
        XCTAssertTrue(mockView.showErrorCalled, "ShowError was not called")
    }
    
    func testGetMoviesFail() {
        XCTAssertFalse(mockView.updateMoviesCalled, "Update movies was called")
    }
    
    func testGetMovies() {
        presenter?.listMovies()
        
        XCTAssertTrue(mockView.updateMoviesCalled)
        XCTAssertTrue(presenter?.movies.count == 4, "No movies")
    }
    
    func testListOption() {
        XCTAssert(presenter?.movieListOption == .trending, "Wrong list option")
    }
    
    func testMovieReturned() {
        presenter?.listMovies()
        guard let movie = presenter?.movies[0] else {
            XCTFail("No movie")
            return
        }
        XCTAssert(movie.title == "Dune", "Wrong movie returned")
    }
    
    func testTitle() {
        XCTAssert(mockView.title == "Trending", "Failure")
    }
    
    func testDidSelectMovie() {
        presenter?.listMovies()
        presenter?.didSelectMovie(at: 0)
        XCTAssertTrue(mockView.didSelectMovieCalled, "Did select was not called")
    }
    
    func testDidSelectMovieFailed() {
        presenter?.listMovies()
        presenter?.movies[3].id = nil
        presenter?.didSelectMovie(at: 3)
        XCTAssertFalse(mockView.didSelectMovieCalled, "The movie Id exists and should not exist")
    }
}
