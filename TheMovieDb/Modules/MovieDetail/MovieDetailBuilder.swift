//
//  MovieDetailBuilder.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 18/11/21.
//

import UIKit.UIViewController

enum MovieDetailBuilder {
    static func createModule(with movie: Movie) -> UIViewController {
        let view = MovieDetailView()
        let service = APIService()
        let presenter: MovieDetailPresenterInteractorProtocol = MovieDetailPresenter()
        let interactor: MovieDetailInteractorDataManagerProtocol = MovieDetailInteractor()
        let remoteDataManager: MovieDetailRemoteDataManagerInputProtocol = MovieDetailRemoteDataManager(service: service)
        let router: MovieDetailRouterProtocol = MovieDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.setMovie(movie)
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
