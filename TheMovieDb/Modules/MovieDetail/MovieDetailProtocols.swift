//
//  MovieDetailProtocols.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

protocol MovieDetailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func showRealatedMoviews(_ relatedMovies: [MovieDetailSections: [Movie]])
    func setMovie(_ movie: Movie)
}

protocol MovieDetailRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    func showReviews(from view: MovieDetailViewProtocol, with movie: Movie)
    func showMovie(from view: MovieDetailViewProtocol, with movie: Movie)
}

protocol MovieDetailBuilderProtocol: AnyObject {
    // BUILDER
    static func createModule(with movie: Movie) -> UIViewController
}

protocol MovieDetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
    
    func viewDidLoad()
    func setMovie(_ movie: Movie)
    func showReviews(_ movie: Movie)
    func showMovie(_ movie: Movie)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func moviesFromInteractor(_ relatedMovies: [MovieDetailSections: [Movie]])
}

protocol MovieDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol? { get set }
    
    func getRelatedMovies()
}

protocol MovieDetailDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol MovieDetailRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol? { get set }
    func fetchRelatedMovies()
}

protocol MovieDetailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func relatedMoviesFound(_ relatedMovies: [MovieDetailSections: [Movie]])
}
