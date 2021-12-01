//
//  HomeBuilder.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 18/11/21.
//

import UIKit.UIViewController

enum HomeBuilder: HomeBuilderProtocol {
    static func createModule() -> UIViewController {
        let view = HomeView()
        let service = APIService()
        let moviesWorker = MoviesWorker(service: service)
        let presenter: HomePresenterViewInteractorProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol = HomeInteractor(movieDetailWorker: moviesWorker)
        let wireFrame: HomeRouterProtocol = HomeWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
