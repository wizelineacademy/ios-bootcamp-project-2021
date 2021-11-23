//
//  ReviewDetailInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation

class ReviewDetailInteractor {
    
    // MARK: Properties
    @Published  var review: Review?
    
    init(review: Review) {
        self.review = review
    }
    
}
