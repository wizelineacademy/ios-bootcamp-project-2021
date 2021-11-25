//
//  ReviewDetailProtocols.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

protocol ReviewDetailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: ReviewDetailPresenterProtocol? { get set }
    func presenterPushDataView(receivedReview: Review)
}

protocol ReviewDetailBuilderProtocol {
    static func createModule(with review: Review) -> UIViewController
}

typealias ReviewDetailPresenterInteractorProtocol = ReviewDetailPresenterProtocol & ReviewDetailInteractorOutputProtocol
protocol ReviewDetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ReviewDetailViewProtocol? { get set }
    var interactor: ReviewDetailInteractorInputProtocol? { get set }
    func viewDidLoad()
}

protocol ReviewDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorPushDataPresenter(receivedReview: Review)
}

protocol ReviewDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ReviewDetailInteractorOutputProtocol? { get set }
    func getReview()
}
