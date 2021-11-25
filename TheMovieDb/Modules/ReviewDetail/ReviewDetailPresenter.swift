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
    var interactor: ReviewDetailInteractorInputProtocol?
        
}

extension ReviewDetailPresenter: ReviewDetailPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.getReview()
    }
}

extension ReviewDetailPresenter: ReviewDetailInteractorOutputProtocol {
    func interactorPushDataPresenter(receivedReview: Review) {
        view?.presenterPushDataView(receivedReview: receivedReview)
    }
    
}
