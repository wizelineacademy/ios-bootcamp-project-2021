//
//  ReviewsInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation

class ReviewsInteractor: ReviewsInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: ReviewsInteractorOutputProtocol?
    var localDatamanager: ReviewsLocalDataManagerInputProtocol?
    var remoteDatamanager: ReviewsRemoteDataManagerInputProtocol?

}

extension ReviewsInteractor: ReviewsRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
