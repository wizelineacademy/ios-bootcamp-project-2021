//
//  ReviewViewModel.swift
//  TheMovieDb
//
//  Created by developer on 30/11/21.
//

import UIKit
import SwiftUI

class ReviewListViewModel: ReviewListVideModelProtocol {
    var didFetchReviews: ((_ results: ReviewsViewModelList) -> Void)?
    var apiDataManager: ReviewsAPIDataManagerProtocol
    var reviews: ReviewsViewModelList {
        didSet {
           didFetchReviews?(reviews)
        }
    }
    var movie: MovieProtocol
    
    init(review: ReviewsViewModelList, apiDataManager: ReviewsAPIDataManagerProtocol, movie: MovieProtocol) {
        self.reviews = review
        self.apiDataManager = apiDataManager
        self.movie = movie
    }
    
    func fetchReviewsOfMovie(id: String) {
        
        let request = Request(path: Endpoints.reviewsOfMovie(id: id), method: .get, group: nil)
        print(request.path)
        apiDataManager.requestReviews(value: ReviewsList.self, request: request) { result in
            switch result {
            case .success(let reviewList):
              //  print(reviewList)
                if let reviewsViewModelList = reviewList?.results.map({ review -> ReviewViewModel in
                    let viewModel = ReviewViewModel(review: review)
                    return viewModel
                }) {
                    self.reviews = ReviewsViewModelList(results: reviewsViewModelList)
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
