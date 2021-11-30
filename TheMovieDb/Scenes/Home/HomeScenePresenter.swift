//
//  HomeScenePresenter.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation

typealias HomeScenePresenterInput = HomeSceneInteractorOutput
typealias HomeScenePresenterOutput = HomeSceneViewControllerInput

final class HomeScenePresenter {
    weak var viewController: HomeScenePresenterOutput?
}

extension HomeScenePresenter: HomeScenePresenterInput {
    
    func showHomeSections(sections: [HomeSections]) {
        viewController?.showCollectionView(sections: sections)
    }
}
