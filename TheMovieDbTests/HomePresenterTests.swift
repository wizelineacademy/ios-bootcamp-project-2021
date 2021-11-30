//
//  HomePresenterTests.swift
//  TheMovieDbTests
//
//  Created by Ricardo Ramirez on 29/11/21.
//

import XCTest
@testable import TheMovieDb

class HomePresenterTests: XCTestCase {
    
    var sut: HomePresenter!
    
    var service: MockMovieFeedRepository!
    
    var delegate: MockHomePresenterDelegate!

    override func setUp() {
        super.setUp()
        service = MockMovieFeedRepository()
        delegate = MockHomePresenterDelegate()
        sut = HomePresenter(service: service)
        sut.delegate = delegate
    }
    
    override func tearDown() {
        self.sut = nil
        self.service = nil
        self.delegate = nil
        super.tearDown()
    }
    
    func testCurrentFeedAfterIsSearchingEqualsTrue() {
        sut.isSearching = true
        XCTAssertEqual(sut.currentFeed, .search)
    }
    
    func testStartSearchingDelegateAfterIsSearchingEqualsTrue() {
        sut.isSearching = true
        XCTAssertNotNil(delegate.isSearching)
        XCTAssertTrue(delegate.isSearching!)
    }
    
    func testCurrentFeedAfterIsSearchingEqualsFalse() {
        sut.isSearching = false
        XCTAssertEqual(sut.currentFeed, .trending)
    }
    
    func testFinishSearchingDelegateAfterIsSearchingEqualsFalse() {
        sut.isSearching = false
        XCTAssertNotNil(delegate.isSearching)
        XCTAssertFalse(delegate.isSearching!)
    }
    
    func testServiceIsNotCalledIfIsLoading() {
        service.callCompletion = false
        sut.getMoviesIfNeeded(search: nil)
        sut.getMoviesIfNeeded(search: nil)
        XCTAssertEqual(service.timesCalled, 1)
    }
    
    func testDelegateStartIsLoadingAfterGetMoviesStart() {
        service.callCompletion = false
        sut.getMoviesIfNeeded(search: nil)
        XCTAssertNotNil(delegate.isLoading)
        XCTAssertTrue(delegate.isLoading!)
    }
    
    func testDelegateFinishIsLoadingAfterGetMoviesFinish() {
        sut.getMoviesIfNeeded(search: nil)
        XCTAssertNotNil(delegate.isLoading)
        XCTAssertFalse(delegate.isLoading!)
    }
    
    func testMoviesAfterGetMoviesFinish() {
        service.list = MovieDBAPIListResponse(page: 1, results: MovieStubGenerator.generateMovies(5), totalPages: 1, totalResults: 5)
        sut.getMoviesIfNeeded(search: nil)
        XCTAssertEqual(sut.getMoviesCount(), 5)
    }
    
    func testNilImageAfterImageLoadWithInvalidURL() {
        service.list = MovieDBAPIListResponse(page: 1, results: [MovieStubGenerator.generateMovie(withPosterPath: false)], totalPages: 1, totalResults: 1)
        sut.getMoviesIfNeeded(search: nil)
        let expectation = self.expectation(description: "nilImageAfterImageLoadWithInvalidURL")
        var result: UIImage?
        sut.getMoviePoster(forPosition: 0) { image in
            result = image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNil(result)
    }
    
    func testGetCorrectMovieOnPosition() {
        let list = MovieStubGenerator.generateMovies(5)
        service.list = MovieDBAPIListResponse(page: 1, results: list, totalPages: 1, totalResults: 5)
        sut.getMoviesIfNeeded(search: nil)
        XCTAssertEqual(sut.getMovie(forPosition: 0), list[0])
    }
    
}

class MockMovieFeedRepository: MovieFeedRepository {
    
    var timesCalled = 0
    
    var callCompletion = true
    
    var list: MovieDBAPIListResponse<Movie>?
    
    func getMovieFeed(on feed: FeedTypes, page: Int, query: String?, completion: @escaping (Result<MovieDBAPIListResponse<Movie>, Error>) -> Void) {
        timesCalled += 1
        if callCompletion {
            if let list = list {
                completion(.success(list))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            }
        }
    }
}

class MockHomePresenterDelegate: HomePresenterDelegate {
    
    var isLoading: Bool?
    
    var isSearching: Bool?
    
    func didStartLoading() {
        isLoading = true
    }
    
    func didFinishLoading() {
        isLoading = false
    }
    
    func didStartSearching() {
        isSearching = true
    }
    
    func didFinishSearching() {
        isSearching = false
    }
    
    func didUpdateMovies(_ movies: [Movie]) {}
}
