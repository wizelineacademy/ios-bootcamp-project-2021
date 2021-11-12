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
    var localDatamanager: ReviewDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: ReviewDetailRemoteDataManagerInputProtocol?
    
    func interactorGetData() {
        remoteDatamanager?.externalGetData()
    }

}

extension ReviewDetailInteractor: ReviewDetailRemoteDataManagerOutputProtocol {
    func remoteDataManagerCallBackData(with review: Review) {
        presenter?.interactorPushDataPresenter(receivedReview: review)
    }
    
}
