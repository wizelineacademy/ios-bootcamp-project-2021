//
//  DetailSceneConfigurator.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 22/11/21.
//

import Foundation

protocol DetailSceneConfigurator {
    func configured(_ vc: DetailSceneViewController) -> DetailSceneViewController
}

final class DefaultDetailSceneConfigurator: DetailSceneConfigurator {
    
    @discardableResult
    func configured(_ vc: DetailSceneViewController) -> DetailSceneViewController {
        let worker = DetailSceneWorker()
        let interactor = DetailSceneInteractor()
        let presenter = DetailScenePresenter()
        let router = DetailSceneRouter()
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.worker = worker
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
