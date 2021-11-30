//
//  SearchSceneConfigurator.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation

protocol SearchSceneConfigurator {
    func configured(_ vc: SearchSceneViewController,
                    request: (Request & SearchableModel & PageableModel)?) -> SearchSceneViewController
}

final class DefaultSearchSceneConfigurator: SearchSceneConfigurator {
    
    @discardableResult
    func configured(_ vc: SearchSceneViewController,
                    request: (Request & SearchableModel & PageableModel)?) -> SearchSceneViewController {
        let worker = SearchSceneWorker(request: request)
        let interactor = SearchSceneInteractor()
        let presenter = SearchScenePresenter()
        let router = SearchSceneRouter()
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.worker = worker
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
