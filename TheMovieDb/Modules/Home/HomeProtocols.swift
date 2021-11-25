//
//  HomeProtocols.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: HomePresenterProtocol? { get set }
    
    func showMovies(_ movies: [MovieGroupSections: [Movie]])
}

protocol HomeRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    func showMovie(from view: HomeViewProtocol, with movie: Movie)
}

protocol HomeBuilderProtocol {
    // BUILDER
    static func createModule() -> UIViewController
}

typealias HomePresenterViewInteractorProtocol = HomePresenterProtocol & HomeInteractorOutputProtocol
protocol HomePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidLoad()
    func showMovie(_ movie: Movie)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func moviesObtained(_ movies: [MovieGroupSections: [Movie]])
}

typealias HomeInteractorDataManagerProtocol = HomeInteractorInputProtocol & HomeRemoteDataManagerOutputProtocol
protocol HomeInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: HomeInteractorOutputProtocol? { get set }
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol? { get set }
    
    func getMovies()
}

protocol HomeRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
    func fetchMovies()
}

protocol HomeRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func fetchedMovies(_ movies: [MovieGroupSections: [Movie]])
}
