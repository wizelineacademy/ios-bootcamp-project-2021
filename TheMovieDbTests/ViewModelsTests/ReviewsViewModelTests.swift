//
//  ReviewsViewModelTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 16/11/21.
//

import XCTest
import Combine
@testable import TheMovieDb

class ReviewsViewModelTests: XCTestCase {

    var viewModel: ReviewsViewModel?
    var facade = MockService()
    var subscriptions = Set<AnyCancellable>()
    
    override func setUp() {
        viewModel = ReviewsViewModel(id: 0, facade: facade)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testReviewsFailure() {
        facade.failure = true
        let expectation = XCTestExpectation(description: "Reviews received")
        expectation.expectedFulfillmentCount = 2
        
        viewModel?.$activeError
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        
        viewModel?.reviewsMovie()
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(viewModel?.activeError, "Did not received an active error")
    }
    
    func testReviewsSuccess() {
        let expectedReviews = [ReviewsDetails(author: "Karla", content: "Excelent"),
                               ReviewsDetails(author: "Daniela", content: "Bad movie")]
        var resultReviews = [ReviewsDetails]()
        let expectation = XCTestExpectation(description: "Reviews received")
        expectation.expectedFulfillmentCount = 2
        
        viewModel?.$reviews
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Failed to retrieve the reviews")
                case .finished:
                    break
                }
            }, receiveValue: { reviews in
                resultReviews = reviews
                expectation.fulfill()
            }).store(in: &subscriptions)
        
        viewModel?.reviewsMovie()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(resultReviews.count == expectedReviews.count, "Different quantity of reviews.")
        XCTAssertTrue(resultReviews.first?.author == expectedReviews.first?.author, "Different author for first review")
    }
}
