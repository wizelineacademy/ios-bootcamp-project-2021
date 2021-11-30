//
//  MoviesDetailInteractorTest.swift
//  TheMovieDbTests
//
//  Created by developer on 30/11/21.
//

import XCTest
@testable import TheMovieDb

class MoviesDetailInteractorTest: XCTestCase {

    var sut: MoviesDetailInteractor?
    var  apiDataManager: MoviesDetailAPIManagerMock?
    var presenter: MoviesDetailPresenterMock?
    
    override func setUp() {
        sut = MoviesDetailInteractor()
        apiDataManager = MoviesDetailAPIManagerMock()
        presenter = MoviesDetailPresenterMock()
        sut?.presenter = presenter
        sut?.apiDataManager = apiDataManager
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchMovieDetailSucced() {
        let movie = Movie(title: "1", id: 1, posterPath: "1", overview: "1")
        sut?.fetchDetail(of: movie)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            if let didFetchMovies = self.presenter?.didFetchMovies {
                XCTAssertTrue(didFetchMovies)
            }
        })
    }
    
    func testsFetchSimilarMovies() {
        let movie = Movie(title: "1", id: 1, posterPath: "1", overview: "1")
        sut?.fetchSimilarMoviesFor(movie: movie)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            if let didFetchMovies = self.presenter?.didFetchMovies {
                XCTAssertTrue(didFetchMovies)
            }
        })
    }

}
