//
//  ReviewDetailInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation

class ReviewDetailInteractor: ReviewDetailInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: ReviewDetailInteractorOutputProtocol?
    private let review: Review
    
    init(review: Review) {
        self.review = review
        
    }
    
    func getReview() {
        presenter?.interactorPushDataPresenter(receivedReview: self.review)
    }

}
