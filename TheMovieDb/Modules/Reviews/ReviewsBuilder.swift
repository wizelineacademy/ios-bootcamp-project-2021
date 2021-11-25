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
        let service = APIService()
        let presenter: ReviewsPresenterInteractorProtocol = ReviewsPresenter()
        let interactor: ReviewsInteractorDataManagerProtocol = ReviewsInteractor(movie: movie)
        let remoteDataManager: ReviewsRemoteDataManagerInputProtocol = ReviewsRemoteDataManager(service: service)
        let router: ReviewsRouterProtocol = ReviewsRouter()
        
        view.presenter = presenter
        //
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        //
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
