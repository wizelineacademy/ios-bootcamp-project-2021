//
//  ReviewDetailPresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation

class ReviewDetailPresenter {
    
    // MARK: Properties
    weak var view: ReviewDetailViewProtocol?
    var interactor: ReviewDetailInteractorInputProtocol?
    var wireFrame: ReviewDetailWireFrameProtocol?
    
}

extension ReviewDetailPresenter: ReviewDetailPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        interactor?.interactorGetData()
    }
}

extension ReviewDetailPresenter: ReviewDetailInteractorOutputProtocol {
    func interactorPushDataPresenter(receivedReview: Review) {
        view?.presenterPushDataView(receivedReview: receivedReview)
    }
}
