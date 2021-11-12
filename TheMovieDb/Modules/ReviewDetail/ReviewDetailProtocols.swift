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
    var interactor: ReviewDetailInteractorInputProtocol? { get set }
    var wireFrame: ReviewDetailWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol ReviewDetailInteractorOutputProtocol: AnyObject {
    func interactorPushDataPresenter(receivedReview: Review)
}

protocol ReviewDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ReviewDetailInteractorOutputProtocol? { get set }
    var localDatamanager: ReviewDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ReviewDetailRemoteDataManagerInputProtocol? { get set }
    func interactorGetData()
}

protocol ReviewDetailDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ReviewDetailRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ReviewDetailRemoteDataManagerOutputProtocol? { get set }
    func externalGetData()
    func setReview(settedReview: Review)
}

protocol ReviewDetailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteDataManagerCallBackData(with review: Review)
}

protocol ReviewDetailLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
