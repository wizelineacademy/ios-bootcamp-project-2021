//
//  ListSectionSceneInteractor.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation

typealias ListSectionSceneInteractorInput = ListSectionSceneViewControllerOutput

protocol ListSectionSceneInteractorOutput: AnyObject {
    func showResults(result: PageModel<MovieModel>)
    func showError(message: String)
}

final class ListSectionSceneInteractor {
    var presenter: ListSectionScenePresenterInput?
    var worker: ListSectionSceneWorker?
}

extension ListSectionSceneInteractor: ListSectionSceneInteractorInput {
    
    func callSectionQuery() {
        worker?.callToMoviesRequest(completion: { result in
            self.presenter?.showResults(result: result)
        }, onError: { error in
            self.presenter?.showError(message: error.localizedDescription)
        })
    }
    
    func resetCounter() {
        worker?.resetCounter()
    }
}
