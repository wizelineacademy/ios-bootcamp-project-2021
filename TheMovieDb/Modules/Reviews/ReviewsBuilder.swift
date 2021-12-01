//
//  ReviewsBuilder.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 18/11/21.
//

import UIKit.UIViewController

enum ReviewsBuilder: ReviewsBuilderProtocol {
    static func createModule(movie: Movie) -> UIViewController {
        let view = ReviewsView()
        let reviewsWorker: ReviewsWorkerProtocol = ReviewsWorker()
        let presenter: ReviewsPresenterInteractorProtocol = ReviewsPresenter()
        let interactor: ReviewsInteractorInputProtocol = ReviewsInteractor(movie: movie, reviewWorker: reviewsWorker)
        let router: ReviewsRouterProtocol = ReviewsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }
}
