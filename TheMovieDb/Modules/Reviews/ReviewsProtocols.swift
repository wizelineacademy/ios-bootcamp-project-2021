//
//  ReviewsProtocols.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Combine
import UIKit

protocol ReviewsViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: ReviewsPresenterProtocol? { get set }
    func showReviews(reviewViewModel: [ReviewViewModel])
    func showErrorMessage(withMessage error: String)
    func showMessageNoReviews(with message: String)
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
    func onError(errorMessage: String)
    func noReviews(with message: String)
}

protocol ReviewsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ReviewsInteractorOutputProtocol? { get set }
    func getReviews()
}

protocol ReviewsWorkerProtocol {
    // WORKER -> INTERACTOR
    func fetchReviews(with movie: Movie) -> AnyPublisher<Reviews, APIRequestError>
}
