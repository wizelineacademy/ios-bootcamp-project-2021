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
    var remoteDatamanager: ReviewsRemoteDataManagerInputProtocol?
    
    func getReviews(from movie: Movie) {
        remoteDatamanager?.fetchReviews(movie: movie)
    }
    
}

extension ReviewsInteractor: ReviewsRemoteDataManagerOutputProtocol {
    func reviewsFromServer(reviewsData: Reviews) {
        let reviews = reviewsData.reviews
        presenter?.reviewsFromInteractor(reviews: reviews)
    }
    
}
