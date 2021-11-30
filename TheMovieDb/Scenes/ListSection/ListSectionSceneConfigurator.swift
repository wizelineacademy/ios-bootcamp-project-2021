//
//  ListSectionSceneConfigurator.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation

protocol ListSectionSceneConfigurator {
    func configured(_ vc: ListSectionSceneViewController,
                    request: (Request & PageableModel)?) -> ListSectionSceneViewController
}

final class DefaultListSectionSceneConfigurator: ListSectionSceneConfigurator {
    
    @discardableResult
    func configured(_ vc: ListSectionSceneViewController,
                    request: (Request & PageableModel)?) -> ListSectionSceneViewController {
        let worker = ListSectionSceneWorker(request: request)
        let interactor = ListSectionSceneInteractor()
        let presenter = ListSectionScenePresenter()
        let router = ListSectionSceneRouter()
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.worker = worker
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
