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
        guard let moviesDetailViewController = storyboad.instantiateViewController(withIdentifier: "MovieDetailViewControllerMVVM") as? MovieDetailViewControllerMVVM else { return nil }
      
        let apiDataManager = MoviesDetailAPIDataManager()
        let router = MoviesDetailRouter()
        let viewModel = MovieDetailViewModel(movie: movie, apiManager: apiDataManager, router: router)
        moviesDetailViewController.viewModel = viewModel
       return moviesDetailViewController
    }
}
