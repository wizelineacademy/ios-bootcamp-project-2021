//
//  MoviesDetailBuilder.swift
//  TheMovieDb
//
//  Created by developer on 20/11/21.
//

import Foundation
import UIKit

struct MoviesDetailBuilder: MoviesDetailBuilderProtocol {
    static func buildModuleWith(movie: MovieProtocol) -> UIViewController? {
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        guard let moviesDetailViewController = storyboad.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return nil }
        moviesDetailViewController.movie = movie
        let presenter = MoviesDetailPresenter()
        let interactor = MoviesDetailInteractor()
        let router = MoviesDetailRouter()
        let apiDataManager = MoviesDetailAPIDataManager()
        presenter.view = moviesDetailViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.apiDataManager = apiDataManager
        
        moviesDetailViewController.presenter = presenter
        return moviesDetailViewController
    }
}
