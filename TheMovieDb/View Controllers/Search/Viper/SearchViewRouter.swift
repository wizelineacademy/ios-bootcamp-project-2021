//
//  SearchViewRouter.swift
//  TheMovieDb
//
//  Created by developer on 26/11/21.
//

import Foundation
import UIKit

final class SearchViewRouter: SearchViewRouterProtocol {
    func showMovieDetailFrom(view: UIViewController, movie: MovieProtocol) {
        if let movieDetailViewController = MoviesDetailBuilder.buildModuleWith(movie: movie) {
            view.navigationController?.pushViewController(movieDetailViewController, animated: true)
        }
    }
}
