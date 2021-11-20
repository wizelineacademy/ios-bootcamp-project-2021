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
        let presenter: SearchingPresenterProtocol & SearchingInteractorOutputProtocol = SearchingPresenter()
        let interactor: SearchingInteractorInputProtocol & SearchingRemoteDataManagerOutputProtocol = SearchingInteractor()
        let remoteDataManager: SearchingRemoteDataManagerInputProtocol = SearchingRemoteDataManager(service: service)
        let router: SearchingRouterProtocol = SearchingRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return view
        
    }
}
