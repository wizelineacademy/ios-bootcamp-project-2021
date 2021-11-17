//
//  ReviewsDetailViewModelTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 16/11/21.
//

import XCTest
@testable import TheMovieDb

class ReviewsDetailViewModelTests: XCTestCase {
    
    var viewModel: ReviewsDetailViewModel?
    
    override func setUp() {
        viewModel = ReviewsDetailViewModel()
        viewModel?.review = ReviewsDetails(author: "Karla", content: "Excellent")
    }
    
    func testReviewsDetail() {
        XCTAssertEqual(viewModel?.review?.author, "Karla")
        XCTAssertEqual(viewModel?.review?.content, "Excellent")
    }
}
