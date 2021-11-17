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
    
    override func setUp() {
        viewModel = MovieInfoViewModel(facade: MockService())
        viewModel?.movieID = 1
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testMovieDetail() {
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
    
    func testSimilarMovies() {
        viewModel?.similarMovies()
        XCTAssert(viewModel?.similarMoviesNames == "Dune, No time to die, Eternals", "Failure response")
    }
    
    func testRecomendedMovies() {
        viewModel?.recomendedMovies()
        XCTAssert(viewModel?.recommendedMoviesNames == "Dune, No time to die, Eternals", "Failure response")
    }
    
    func testCastMovie() {
        viewModel?.castFromMovie()
        XCTAssert(viewModel?.castMovie == "Brad Pit, Keanu Revees, Jennifer Aniston", "Failure response")
    }
    
    func testFetchService() {
        viewModel?.fetchServices()
        XCTAssertNotNil(viewModel?.movie)
        XCTAssertNotNil(viewModel?.similarMoviesNames)
    }

}
