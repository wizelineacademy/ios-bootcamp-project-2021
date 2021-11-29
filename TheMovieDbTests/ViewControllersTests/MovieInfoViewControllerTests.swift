//
//  MovieInfoViewControllerTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 28/11/21.
//

import XCTest
@testable import TheMovieDb

class MovieInfoViewControllerTests: XCTestCase {

    var sut: MovieInfoViewController?
    var navigationMock: MockNavigationController?
    
    override func setUp() {
        sut = MovieInfoViewController(facade: MockService())
        sut?.viewModel?.movieID = .zero
        sut?.loadViewIfNeeded()
        
        guard let viewController = sut else {
            return
        }
        
        navigationMock = MockNavigationController(rootViewController: UIViewController())
        navigationMock?.pushViewController(viewController, animated: false)
        navigationMock?.pushViewControllerCalled = false
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testMovieInformation() {
        let expectedMovie = Movie(posterPath: "",
                                   overview: "",
                                   id: 001,
                                   originalTitle: "Dune",
                                   title: "Dune",
                                   originalLanguage: "en",
                                   popularity: 1.1,
                                   adult: false,
                                   releaseDate: "2021-09-30")
        
        let expectation = XCTestExpectation(description: "Movie loaded")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(sut?.viewModel?.movie?.title, expectedMovie.title, "Wrong title loaded")
        XCTAssertEqual(sut?.recommendationsLabel.text, "Recomendations: Dune, No time to die, Eternals", "Wrong recommendations loaded")
        XCTAssertEqual(sut?.similarMoviesLabel.text, "Similar Movies: Dune, No time to die, Eternals", "Wrong similar movies loaded")
        XCTAssertEqual(sut?.castInfoLabel.text, "Cast: Brad Pit, Keanu Revees, Jennifer Aniston", "Wrong cast loaded")
    }
    
    func testDidTappedReviews() {
        sut?.reviewsDisplay()
        XCTAssertTrue(navigationMock?.pushViewControllerCalled ?? false, "Did not called the did select method")
    }
}
