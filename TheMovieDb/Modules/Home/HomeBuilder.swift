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
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol & HomeRemoteDataManagerOutputProtocol = HomeInteractor()
        let remoteDataManager: HomeRemoteDataManagerInputProtocol = HomeRemoteDataManager(service: service)
        let wireFrame: HomeRouterProtocol = HomeWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
