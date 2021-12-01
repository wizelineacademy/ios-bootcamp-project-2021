//
//  MoviesDetailRouter.swift
//  TheMovieDb
//
//  Created by developer on 24/11/21.
//

import Foundation
import UIKit

final class MoviesDetailRouter: MoviesDetailRouterProtocol {
    
    func pushReviewsViewControllerFrom(view: UIViewController, with movie: MovieProtocol) {
        guard let reviewsViewController = ReviewsViewBuilder.buildModuleWith(movie: movie) else { return }
        view.navigationController?.pushViewController(reviewsViewController, animated: true)
    }
        
    func pushDetailViewControllerFrom(view: UIViewController, with movie: MovieProtocol) {
        guard let detailMovieViewController = MoviesDetailBuilder.buildModuleWith(movie: movie) else { return }
        view.navigationController?.pushViewController(detailMovieViewController, animated: true)
    }
}
