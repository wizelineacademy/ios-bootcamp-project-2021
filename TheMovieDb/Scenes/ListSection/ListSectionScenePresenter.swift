//
//  ListSectionScenePresenter.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation

typealias ListSectionScenePresenterInput = ListSectionSceneInteractorOutput
typealias ListSectionScenePresenterOutput = ListSectionSceneViewControllerInput

final class ListSectionScenePresenter {
    weak var viewController: ListSectionScenePresenterOutput?
}

extension ListSectionScenePresenter: ListSectionScenePresenterInput {
    
    func showResults(result: PageModel<MovieModel>) {
        viewController?.showResults(page: result)
    }
}
