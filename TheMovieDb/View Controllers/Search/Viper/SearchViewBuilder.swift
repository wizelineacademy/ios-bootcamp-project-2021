//
//  SearchViewBuilder.swift
//  TheMovieDb
//
//  Created by developer on 25/11/21.
//

import Foundation
import UIKit

final class SearchViewBuilder: SearchViewBuilderProtocol {
    static func buildModule() -> UIViewController? {
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        guard let searchViewController = storyboad.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return nil }
        
        let presenter = SearchViewPresenter()
        let interactor = SearchViewInteractor()
        let apiManager = SearchViewAPIDataManager()
        let router = SearchViewRouter()
        presenter.view = searchViewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.apiDataManager = apiManager
        searchViewController.presenter = presenter
        
        return searchViewController
    }
    
}
