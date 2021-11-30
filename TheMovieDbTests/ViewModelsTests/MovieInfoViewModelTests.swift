//
//  MovieInfoViewModelTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 16/11/21.
//

import XCTest
@testable import TheMovieDb

class MovieInfoViewModelTests: XCTestCase {
    
    var viewModel: MovieInfoViewModel?
    var facade = MockService()
    
    override func setUp() {
        viewModel = MovieInfoViewModel(facade: facade)
        viewModel?.movieID = 1
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testMovieDetailFailure() {
        facade.failure = true
        viewModel?.fetchServices()
        XCTAssertNil(viewModel?.movie, "Failure failed")
        XCTAssertNil(viewModel?.similarMoviesNames, "Failure failed")
        XCTAssertNil(viewModel?.recommendedMoviesNames, "Failure failed")
        XCTAssertNil(viewModel?.castMovie, "Failure failed")
    }
    
    func testMovieDetailSuccess() {
        let expectedMovie = Movie(posterPath: "",
                                  overview: "",
                                  id: 001,
                                  originalTitle: "Dune",
                                  title: "Dune",
                                  originalLanguage: "en",
                                  popularity: 1.1,
                                  adult: false,
                                  releaseDate: "2021-09-30")
        viewModel?.fetchServices()
        XCTAssertEqual(viewModel?.movie?.title, expectedMovie.title, "Failure movie title")
        XCTAssertEqual(viewModel?.movie?.popularity, expectedMovie.popularity, "Failure movie popularity")
        XCTAssertEqual(viewModel?.movie?.releaseDate, expectedMovie.releaseDate, "Failure movie release date")
    }
    
    func testSimilarMoviesFailure() {
        facade.failure = true
        viewModel?.similarMovies()
        XCTAssertNil(viewModel?.castMovie, "Failure failed")
    }
    
    func testSimilarMoviesSuccess() {
        viewModel?.similarMovies()
        XCTAssert(viewModel?.similarMoviesNames == "Dune, No time to die, Eternals", "Failure response")
    }
    
    func testRecommendedMoviesFailure() {
        facade.failure = true
        viewModel?.recomendedMovies()
        XCTAssertNil(viewModel?.recommendedMoviesNames, "Failure failed")
    }
    
    func testRecomendedMoviesSuccess() {
        viewModel?.recomendedMovies()
        XCTAssert(viewModel?.recommendedMoviesNames == "Dune, No time to die, Eternals", "Failure response")
    }
    
    func testCastMovieFailure() {
        facade.failure = true
        viewModel?.castFromMovie()
        XCTAssertNil(viewModel?.castMovie, "Failure failed")
    }
    
    func testCastMovieSuccess() {
        viewModel?.castFromMovie()
        XCTAssert(viewModel?.castMovie == "Brad Pit, Keanu Revees, Jennifer Aniston", "Failure response")
    }

}
