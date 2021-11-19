//
//  ReviewsBuilder.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 18/11/21.
//

import UIKit

enum ReviewsBuilder {
    static func createModule(movie: Movie) -> UIViewController {
        let view = ReviewsView()
        let presenter: ReviewsPresenterProtocol & ReviewsInteractorOutputProtocol = ReviewsPresenter()
        let interactor: ReviewsInteractorInputProtocol & ReviewsRemoteDataManagerOutputProtocol = ReviewsInteractor(movie: movie)
        let remoteDataManager: ReviewsRemoteDataManagerInputProtocol = ReviewsRemoteDataManager()
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
        remoteDataManager.service = APIService()
        
        return view
    }
}
