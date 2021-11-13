//
//  ReviewsPresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

final class ReviewsPresenter {
    
    // MARK: Properties
    weak var view: ReviewsViewProtocol?
    var interactor: ReviewsInteractorInputProtocol?
    var wireFrame: ReviewsWireFrameProtocol?
    
    var movie: Movie?
}

extension ReviewsPresenter: ReviewsPresenterProtocol {
    
    func setMovie(_ movie: Movie) {
        self.movie = movie
    }
    
    func viewDidLoad() {
        guard let movie = movie else { return }
        interactor?.getReviews(from: movie)
    }
    
    func showDetail(review: Review) {
        guard let view = view else { return }
        wireFrame?.showReviewDetail(from: view, with: review)
    }
}

extension ReviewsPresenter: ReviewsInteractorOutputProtocol {
    func reviewsFromInteractor(reviews: [Review]) {
        view?.showReviews(reviews: reviews)
    }
    
}
