//
//  HomeSceneInteractor.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation

typealias HomeSceneInteractorInput = HomeSceneViewControllerOutput

protocol HomeSceneInteractorOutput: AnyObject {
    func showHomeSections(sections: [HomeSections])
}

final class HomeSceneInteractor: HomeSceneInteractorInput {
    
    var presenter: HomeScenePresenterInput?
    var worker: HomeSceneWorker?
    
    func getSections() {
        let sections = worker?.sections ?? []
        presenter?.showHomeSections(sections: sections)
    }
}
