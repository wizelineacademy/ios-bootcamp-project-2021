//
//  MovieDetailBuilder.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 18/11/21.
//

import UIKit

enum MovieDetailBuilder {
    static func createModule(with movie: Movie) -> UIViewController {
        let view = MovieDetailView()
        let service = APIService()
        let presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter()
        let interactor: MovieDetailInteractorInputProtocol & MovieDetailRemoteDataManagerOutputProtocol = MovieDetailInteractor()
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
