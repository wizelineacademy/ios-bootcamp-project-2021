//
//  ReviewsViewModelTests.swift
//  TheMovieDbTests
//
//  Created by Ricardo Ramirez on 19/11/21.
//

import XCTest
@testable import TheMovieDb

class ReviewsViewModelTests: XCTestCase {
    
    var movie: Movie!
    
    var sut: ReviewsViewModel!
    
    var service: MockMovieReviewsRepository!

    override func setUp() {
        super.setUp()
        movie = MovieStubGenerator.generateMovie()
        service = MockMovieReviewsRepository()
        let dependencies = ReviewsViewModel.Dependencies(movie: movie, service: service)
        sut = ReviewsViewModel(dependencies: dependencies)
    }
    
    override func tearDown() {
        self.sut = nil
        self.service = nil
        self.movie = nil
        super.tearDown()
    }
    
    func testIsNotLoadingAtInitialState() {
        XCTAssertFalse(sut.isLoading)
    }
    
    func testHasNotReachedEndAtInitialState() {
        XCTAssertFalse(sut.hasReachedEnd)
    }
    
    func testReviewsAfterSuccessFetching() {
        service.reviewList = MovieDBAPIListResponse(page: 1, results: ReviewStubGenerator.generateReviews(10), totalPages: 10, totalResults: 100)
        sut.getReviewsIfNeeded()
        XCTAssertEqual(sut.reviews.count, 10)
        XCTAssertFalse(sut.hasReachedEnd)
    }
    
    func testAppendingReviewsAfterSuccessFetching() {
        service.reviewList = MovieDBAPIListResponse(page: 1, results: ReviewStubGenerator.generateReviews(10), totalPages: 10, totalResults: 100)
        sut.getReviewsIfNeeded()
        service.reviewList = MovieDBAPIListResponse(page: 2, results: ReviewStubGenerator.generateReviews(10), totalPages: 10, totalResults: 100)
        sut.getReviewsIfNeeded()
        XCTAssertEqual(sut.reviews.count, 20)
        XCTAssertFalse(sut.hasReachedEnd)
    }
    
    func testHasReachedEndAfterSuccessFetching() {
        service.reviewList = MovieDBAPIListResponse(page: 1, results: ReviewStubGenerator.generateReviews(10), totalPages: 2, totalResults: 100)
        sut.getReviewsIfNeeded()
        service.reviewList = MovieDBAPIListResponse(page: 2, results: ReviewStubGenerator.generateReviews(10), totalPages: 2, totalResults: 100)
        sut.getReviewsIfNeeded()
        XCTAssertTrue(sut.hasReachedEnd)
    }
    
    func testReviewsAfterFailureFetching() {
        sut.getReviewsIfNeeded()
        XCTAssertEqual(sut.reviews.count, 0)
        XCTAssertFalse(sut.hasReachedEnd)
    }

}

class MockMovieReviewsRepository: MovieReviewsRepository {
    
    var reviewList: MovieDBAPIListResponse<Review>?
    
    func getMoviewReviews(for movie: Movie, page: Int, completion: @escaping (Result<MovieDBAPIListResponse<Review>, Error>) -> Void) {
        if let reviewList = reviewList {
            completion(.success(reviewList))
        } else {
            completion(.failure(NSError(domain: "", code: 1, userInfo: nil)))
        }
    }
}

class ReviewStubGenerator {
    class func generateReview() -> Review {
        Review(author: UUID().uuidString, content: UUID().uuidString, id: UUID().uuidString)
    }
    
    class func generateReviews(_ count: Int) -> [Review] {
        (0..<count).map { _ in generateReview() }
    }
}
