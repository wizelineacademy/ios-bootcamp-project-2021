//
//  SearchViewModelTest.swift
//  TheMovieDbTests
//
//  Created by Rob Cruz on 30/11/21.
//

import XCTest
import UIKit
@testable import TheMovieDb

class SearchViewModelTest: XCTestCase {
    var sut: SearchViewModel!
    
    override func setUp() {
        super.setUp()
        sut = SearchViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAny() {
        sut.movies = MovieMock().movies
        let moviesRows = sut.numberOfRowsInSection()
        let expectedValue = 2
        XCTAssert(moviesRows == expectedValue)
        
    }
    
    func testCellforRowAt() {
        sut.movies = MovieMock().movies
        let movies = sut.cellForRowAt(indexPath: IndexPath(row: 0, section: 0))
        let expectedValue = 63
        XCTAssert(movies.id == expectedValue)
    }
}

class MovieMock {
    var movies: [Movie] = [Movie(id: 63, title: "Matrix", releaseDate: "8392345", voteAverage: 10.0, posterPath: "awqewwq.jpg", overview: "fasafggas", backdropPath: "fasff.jpg"),
                           Movie(id: 65, title: "Matrix2", releaseDate: "124566", voteAverage: 9.0, posterPath: "awqewwqd.jpg", overview: "23dgggas", backdropPath: "fagtff.jpg")]
}
