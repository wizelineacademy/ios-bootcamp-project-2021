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
}

final class DetailSceneInteractor {
    var presenter: DetailScenePresenterInput?
    var worker: DetailSceneWorker?
}

extension DetailSceneInteractor: DetailSceneInteractorInput {
    
    func callToDetailServices(reviewRequest: ReviewRequest, recommendationRequest: RecommendationsRequest) {
        worker?.callDetailServices(reviewRequest: reviewRequest,
                                   recommendationRequest: recommendationRequest,
                                   completion: { reviews, recommendations in
            self.presenter?.showDetailMovie(reviews: reviews, recommendations: recommendations)
        })
    }
}
