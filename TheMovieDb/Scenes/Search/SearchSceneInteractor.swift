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
        })
    }
    
    func resetCounter() {
        worker?.resetCounter()
    }
}
