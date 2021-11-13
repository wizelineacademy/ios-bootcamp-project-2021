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
    func showReviews(reviews: [Review])
}

protocol ReviewsWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createReviewsModule(movie: Movie) -> UIViewController
    func showReviewDetail(from view: ReviewsViewProtocol, with review: Review)
}

protocol ReviewsPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ReviewsViewProtocol? { get set }
    var interactor: ReviewsInteractorInputProtocol? { get set }
    var wireFrame: ReviewsWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func setMovie(_ movie: Movie)
    func showDetail(review: Review)
}

protocol ReviewsInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func reviewsFromInteractor(reviews: [Review])
}

protocol ReviewsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ReviewsInteractorOutputProtocol? { get set }
    var remoteDatamanager: ReviewsRemoteDataManagerInputProtocol? { get set }
    
    func getReviews(from movie: Movie)
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
