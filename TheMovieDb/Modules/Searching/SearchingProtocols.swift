//
//  SearchingProtocols.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

protocol SearchingViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SearchingPresenterProtocol? { get set }
    func showMoviesResults(_ moviesFound: [MovieViewModel])
    func showSpinnerView()
    func stopSpinnerView()
}

protocol SearchingRouterProtocol: AnyObject {
    // PRESENTER -> Router
    func showMovieDetail(from view: SearchingViewProtocol, with movie: Movie)
}

protocol SearchingBuilderProtocol {
    // PRESENTER -> WIREFRAME
    static func createModule() -> UIViewController
}

typealias SearchingPresenterInteractorProtocol = SearchingPresenterProtocol & SearchingInteractorOutputProtocol
protocol SearchingPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SearchingViewProtocol? { get set }
    var interactor: SearchingInteractorInputProtocol? { get set }
    var router: SearchingRouterProtocol? { get set }
    
    func viewDidLoad()
    func searchMovies(_ searchText: String)
    func showMovie(_ movie: Movie)
}

protocol SearchingInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func moviesFound(moviesFound: [MovieViewModel])
}

typealias SearchingInteractorDataManagerProtocol = SearchingInteractorInputProtocol & SearchingRemoteDataManagerOutputProtocol
protocol SearchingInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SearchingInteractorOutputProtocol? { get set }
    var remoteDatamanager: SearchingRemoteDataManagerInputProtocol? { get set }
    
    func findMovies(_ searchText: String)
    
}

protocol SearchingRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SearchingRemoteDataManagerOutputProtocol? { get set }

    func fetchMovies(_ searchText: String)
}

protocol SearchingRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func moviesFound(found movies: Movies)
}
