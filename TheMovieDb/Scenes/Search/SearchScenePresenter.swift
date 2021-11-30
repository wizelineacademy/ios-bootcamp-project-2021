//
//  SearchScenePresenter.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation

typealias SearchScenePresenterInput = SearchSceneInteractorOutput
typealias SearchScenePresenterOutput = SearchSceneViewControllerInput

final class SearchScenePresenter {
    weak var viewController: SearchScenePresenterOutput?
}

extension SearchScenePresenter: SearchScenePresenterInput {
    
    func showQueryResult(result: PageModel<MovieModel>) {
        viewController?.showSearchResult(page: result)
    }
}
