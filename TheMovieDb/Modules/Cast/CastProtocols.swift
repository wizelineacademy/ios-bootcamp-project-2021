//
//  CastProtocols.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/11/21.
//

import Combine
import UIKit

protocol CastViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: CastPresenterProtocol? { get set }
    func showCast(castViewModel: [CastViewModel])
    func showErrorMessage(withMessage error: String)
    func showMessageNoCast(with message: String)
    func showSpinnerView()
    func stopSpinnerView()
}

protocol CastBuilderProtocol {
    // BUILDER
    static func createModule(movie: Movie) -> UIViewController
}

typealias CastPresenterInteractorProtocol = CastPresenterProtocol & CastInteractorOutputProtocol
protocol CastPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: CastViewProtocol? { get set }
    var interactor: CastInteractorInputProtocol? { get set }

    func viewDidLoad()
}

protocol CastInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func castFromInteractor(castViewModel: [CastViewModel])
    func onError(errorMessage: String)
    func noCast(with message: String)
}

protocol CastInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CastInteractorOutputProtocol? { get set }
    func getCast()
}

protocol CastWorkerProtocol {
    // WORKER -> INTERACTOR
    func fetchCredits(with movie: Movie) -> AnyPublisher<CreditsMovie, APIRequestError>
}
