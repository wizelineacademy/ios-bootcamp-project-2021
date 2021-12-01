//
//  MovieDetailWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import UIKit.UINavigationController

class MovieDetailRouter: MovieDetailRouterProtocol {

    func showReviews(from view: MovieDetailViewProtocol, with movie: Movie) {
        let reviewDetail = ReviewsBuilder.createModule(movie: movie)
        guard let view = view as? MovieDetailView else { return }
        let nav = UINavigationController(rootViewController: reviewDetail)
        view.present(nav, animated: true)
    }
    
    func showCast(from view: MovieDetailViewProtocol, with movie: Movie) {
        let castView = CastBuilder.createModule(movie: movie)
        guard let view = view as? MovieDetailView else { return }
        let nav = UINavigationController(rootViewController: castView)
        view.present(nav, animated: true)
    }
    
    func showMovie(from view: MovieDetailViewProtocol, with movie: Movie) {
        let controller = MovieDetailBuilder.createModule(with: movie)
        guard let view = view as? MovieDetailView else { return }
        view.navigationController?.pushViewController(controller, animated: true)
    }

}
