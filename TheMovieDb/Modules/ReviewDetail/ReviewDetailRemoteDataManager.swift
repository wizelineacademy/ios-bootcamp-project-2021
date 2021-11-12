//
//  ReviewDetailRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation

class ReviewDetailRemoteDataManager: ReviewDetailRemoteDataManagerInputProtocol {
   
    var remoteRequestHandler: ReviewDetailRemoteDataManagerOutputProtocol?
    var review: Review?
    
    func externalGetData() {
        guard let review = review else { return }

        remoteRequestHandler?.remoteDataManagerCallBackData(with: review)
    }
    
    func setReview(settedReview: Review) {
        self.review = settedReview
    }
    
}
