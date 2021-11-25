//
//  MoviesHomeBuilder.swift
//  TheMovieDb
//
//  Created by developer on 17/11/21.
//

import UIKit

struct MoviesHomeBuilder: MoviesHomeBuilderProtocol {
    static func buildModule() -> UIViewController? {
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        guard let homeViewController = storyboad.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else { return nil}
       
        let presenter = MoviesHomePresenter()
        let interactor = MoviesHomeInteractor()
        let router = MoviesHomeRouter()
        let apiDataManager = MoviesHomeAPIDataManager()
        
        homeViewController.presenter = presenter
        presenter.view = homeViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.apiDataManager = apiDataManager
        
        return homeViewController
    }
}
