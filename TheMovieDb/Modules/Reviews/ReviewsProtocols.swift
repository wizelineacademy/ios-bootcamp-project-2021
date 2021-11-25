//
//  ReviewsProtocols.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

protocol ReviewsViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: ReviewsPresenterProtocol? { get set }
    func showReviews(reviewViewModel: [ReviewViewModel])
}

protocol ReviewsRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    func showReviewDetail(from view: ReviewsViewProtocol, with review: Review)
}

protocol ReviewsBuilderProtocol {
    // BUILDER
    static func createModule(movie: Movie) -> UIViewController
}

typealias ReviewsPresenterInteractorProtocol = ReviewsPresenterProtocol & ReviewsInteractorOutputProtocol
protocol ReviewsPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ReviewsViewProtocol? { get set }
    var interactor: ReviewsInteractorInputProtocol? { get set }
    var router: ReviewsRouterProtocol? { get set }
    
    func viewDidLoad()
    func showDetail(review: Review)
}

protocol ReviewsInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func reviewsFromInteractor(reviewViewModel: [ReviewViewModel])
}

typealias ReviewsInteractorDataManagerProtocol = ReviewsInteractorInputProtocol & ReviewsRemoteDataManagerOutputProtocol
protocol ReviewsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ReviewsInteractorOutputProtocol? { get set }
    var remoteDatamanager: ReviewsRemoteDataManagerInputProtocol? { get set }
    
    func getReviews()
}

protocol ReviewsRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ReviewsRemoteDataManagerOutputProtocol? { get set }
    func fetchReviews(movie: Movie)
}

protocol ReviewsRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func reviewsFromServer(reviewsData: Reviews)
}
