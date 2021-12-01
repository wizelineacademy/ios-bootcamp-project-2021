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
        let moviesWorker = MoviesWorker(service: service)
        let presenter: MovieDetailPresenterInteractorProtocol = MovieDetailPresenter()
        let interactor: MovieDetailInteractorInputProtocol = MovieDetailInteractor(movieDetailWorker: moviesWorker, movie: movie)

        let router: MovieDetailRouterProtocol = MovieDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
