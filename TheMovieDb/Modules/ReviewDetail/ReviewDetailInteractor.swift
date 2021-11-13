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
    var review: Review?
    func interactorGetData() {
        guard let review = review else { return }
        presenter?.interactorPushDataPresenter(receivedReview: review)
    }

    func setReview(settedReview: Review) {
        self.review = settedReview
    }
}
