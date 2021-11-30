//
//  SearchSceneInteractor.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation

typealias SearchSceneInteractorInput = SearchSceneViewControllerOutput

protocol SearchSceneInteractorOutput: AnyObject {
    func showQueryResult(result: PageModel<MovieModel>)
    func showErrorMessage(message: String)
}

final class SearchSceneInteractor {
    var presenter: SearchScenePresenterInput?
    var worker: SearchSceneWorker?
}

extension SearchSceneInteractor: SearchSceneInteractorInput {
    
    func callToSearchQuery(query: String) {
        worker?.callSearchQuery(query: query,
                                completion: { result in
            self.presenter?.showQueryResult(result: result)
        }, onError: { error in
            self.presenter?.showErrorMessage(message: error.localizedDescription)
        })
    }
    
    func resetCounter() {
        worker?.resetCounter()
    }
}
