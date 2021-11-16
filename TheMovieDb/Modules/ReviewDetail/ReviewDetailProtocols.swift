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

protocol ReviewDetailWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createReviewDetailModule(with review: Review) -> UIViewController
}

protocol ReviewDetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ReviewDetailViewProtocol? { get set }
    var wireFrame: ReviewDetailWireFrameProtocol? { get set }
    func viewDidLoad()
    func setReview(settedReview: Review)
}

protocol ReviewDetailInteractorOutputProtocol: AnyObject {
    func interactorPushDataPresenter(receivedReview: Review)
}

protocol ReviewDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ReviewDetailInteractorOutputProtocol? { get set }
    func interactorGetData()
    func setReview(settedReview: Review)
}
