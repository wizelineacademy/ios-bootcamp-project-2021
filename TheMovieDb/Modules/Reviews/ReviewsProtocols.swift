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
}

protocol ReviewsWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createReviewsModule() -> UIViewController
}

protocol ReviewsPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ReviewsViewProtocol? { get set }
    var interactor: ReviewsInteractorInputProtocol? { get set }
    var wireFrame: ReviewsWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol ReviewsInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol ReviewsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ReviewsInteractorOutputProtocol? { get set }
    var localDatamanager: ReviewsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ReviewsRemoteDataManagerInputProtocol? { get set }
}

protocol ReviewsDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ReviewsRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ReviewsRemoteDataManagerOutputProtocol? { get set }
}

protocol ReviewsRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol ReviewsLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
