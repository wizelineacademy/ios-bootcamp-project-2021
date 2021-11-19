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
    var router: ReviewsRouterProtocol?

}

extension ReviewsPresenter: ReviewsPresenterProtocol {

    func viewDidLoad() {
        interactor?.getReviews()
    }
    
    func showDetail(review: Review) {
        guard let view = view else { return }
        router?.showReviewDetail(from: view, with: review)
    }
}

extension ReviewsPresenter: ReviewsInteractorOutputProtocol {
    func reviewsFromInteractor(reviewViewModel: [ReviewViewModel]) {
        view?.showReviews(reviewViewModel: reviewViewModel)
    }
    
}
