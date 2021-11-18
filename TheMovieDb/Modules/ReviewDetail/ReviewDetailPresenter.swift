//
//  ReviewDetailPresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation

final class ReviewDetailPresenter {
    
    // MARK: Properties
    weak var view: ReviewDetailViewProtocol?
    var wireFrame: ReviewDetailWireFrameProtocol?
    var review: Review?
        
    func setReview(settedReview: Review) {
        self.review = settedReview
    }
    
}

extension ReviewDetailPresenter: ReviewDetailPresenterProtocol {
    
    func viewDidLoad() {
        guard let review = review else { return }
        view?.presenterPushDataView(receivedReview: review)
    }
}
