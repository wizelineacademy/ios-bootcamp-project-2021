//
//  MovieDetailWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

class MovieDetailWireFrame: MovieDetailWireFrameProtocol {

    static func createMovieDetailModule(with movie: Movie) -> UIViewController {
        let view = MovieDetailView()
        let presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter()
        let interactor: MovieDetailInteractorInputProtocol & MovieDetailRemoteDataManagerOutputProtocol = MovieDetailInteractor()
        let localDataManager: MovieDetailLocalDataManagerInputProtocol = MovieDetailLocalDataManager()
        let remoteDataManager: MovieDetailRemoteDataManagerInputProtocol = MovieDetailRemoteDataManager()
        let wireFrame: MovieDetailWireFrameProtocol = MovieDetailWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        presenter.setMovie(movie)
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        remoteDataManager.service = APIService()
        
        return view
    }
    
    func showReviews(from view: MovieDetailViewProtocol, with movie: Movie) {
        let reviewDetail = ReviewsWireFrame.createReviewsModule(movie: movie)
        guard let view = view as? MovieDetailView else { return }
        let nav = UINavigationController(rootViewController: reviewDetail)
        view.present(nav, animated: true)
    }
    
    func showMovie(from view: MovieDetailViewProtocol, with movie: Movie) {
        let controller = MovieDetailWireFrame.createMovieDetailModule(with: movie)
        guard let view = view as? MovieDetailView else { return }
        view.navigationController?.pushViewController(controller, animated: true)
    }

}
