//
//  MovieHomeInteractorTest.swift
//  TheMovieDbTests
//
//  Created by developer on 29/11/21.
//

import XCTest
@testable import TheMovieDb

class MovieHomeInteractorTest: XCTestCase {

    var sut: MoviesHomeInteractor?
    var  apiDataManager: MoviesHomeAPIManagerMock?
    var presenter: MoviesHomePresenterMock?
    
    override func setUp() {
        sut = MoviesHomeInteractor()
        apiDataManager = MoviesHomeAPIManagerMock()
        presenter = MoviesHomePresenterMock()
        sut?.presenter = presenter
        sut?.apiDataManager = apiDataManager
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchMoviesSucced() {
        sut?.fetchMovies()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            if let didFetchMovies = self.presenter?.didFetchMovies {
                XCTAssertTrue(didFetchMovies)
            }
        })
        
    }
}
