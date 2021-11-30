//
//  HomeSceneConfigurator.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation

protocol HomeSceneConfigurator {
    func configured(_ vc: HomeSceneViewController) -> HomeSceneViewController
}

final class DefaultHomeSceneConfigurator: HomeSceneConfigurator {
    
    @discardableResult
    func configured(_ vc: HomeSceneViewController) -> HomeSceneViewController {
        let worker = HomeSceneWorker()
        let interactor = HomeSceneInteractor()
        let presenter = HomeScenePresenter()
        let router = HomeSceneRouter()
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.worker = worker
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
