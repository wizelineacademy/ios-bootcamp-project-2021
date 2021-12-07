//
//  DetailSceneInteractor.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 21/11/21.
//

import Foundation

typealias DetailSceneInteractorInput = DetailSceneViewControllerOutput

protocol DetailSceneInteractorOutput: AnyObject {
    func showDetailMovie(reviews: [ReviewModel], recommendations: [MovieModel])
    func showErrorMessage(message: String)
}

final class DetailSceneInteractor {
    var presenter: DetailScenePresenterInput?
    var worker: DetailSceneWorker?
    var isPaginationEnabled: Bool = true
}

extension DetailSceneInteractor: DetailSceneInteractorInput {
    
    func callToDetailServices(reviewRequest: ReviewRequest, recommendationRequest: RecommendationsRequest) {
        worker?.callDetailServices(reviewRequest: reviewRequest,
                                   recommendationRequest: recommendationRequest,
                                   completion: { reviews, recommendations in
            self.presenter?.showDetailMovie(reviews: reviews, recommendations: recommendations)
        }, onError: { error in
            self.presenter?.showErrorMessage(message: error.localizedDescription)
        })
    }
}
