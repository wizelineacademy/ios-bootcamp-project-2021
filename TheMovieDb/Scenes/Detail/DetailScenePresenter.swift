//
//  DetailScenePresenter.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 21/11/21.
//

import Foundation

typealias DetailScenePresenterInput = DetailSceneInteractorOutput
typealias DetailScenePresenterOutput = DetailSceneViewControllerInput

final class DetailScenePresenter {
    weak var viewController: DetailScenePresenterOutput?
}

extension DetailScenePresenter: DetailScenePresenterInput {
    
    func showDetailMovie(reviews: [ReviewModel], recommendations: [MovieModel]) {
        viewController?.showMovieDetails(reviews: reviews, recommendations: recommendations)
    }
}
