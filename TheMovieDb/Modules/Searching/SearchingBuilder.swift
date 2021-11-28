//
//  SearchingBuilder.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 18/11/21.
//

import UIKit.UIViewController

enum SearchingBuilder: SearchingBuilderProtocol {
    static func createModule() -> UIViewController {
        let view = SearchingView()
        let service = APIService()
        let moviesWorker = MoviesWorker(service: service)
        let presenter: SearchingPresenterInteractorProtocol = SearchingPresenter()
        let interactor: SearchingInteractorInputProtocol = SearchingInteractor(movieDetailWorker: moviesWorker)
        let router: SearchingRouterProtocol = SearchingRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
        
    }
}
