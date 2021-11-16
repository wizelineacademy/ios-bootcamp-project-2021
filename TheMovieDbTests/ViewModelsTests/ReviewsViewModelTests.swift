//
//  ReviewsViewModelTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 16/11/21.
//

import XCTest
@testable import TheMovieDb

class ReviewsViewModelTests: XCTestCase {

    var viewModel: ReviewsViewModel?
    
    override func setUp() {
        viewModel = ReviewsViewModel(facade: MockService())
        viewModel?.movieID = 1
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testReviews() {
        let expectedReviews = [ReviewsDetails(author: "Karla", content: "Excelent"),
                               ReviewsDetails(author: "Daniela", content: "Bad movie")]
        viewModel?.reviewsMovie()
        XCTAssertEqual(viewModel?.reviews.count, expectedReviews.count)
        XCTAssertEqual(viewModel?.reviews[0].author, expectedReviews[0].author)
    }
}
