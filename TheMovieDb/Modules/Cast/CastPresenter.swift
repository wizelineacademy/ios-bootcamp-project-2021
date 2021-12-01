//
//  CastPresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/11/21.
//

import UIKit

final class CastPresenter {
    
    // MARK: Properties
    weak var view: CastViewProtocol?
    var interactor: CastInteractorInputProtocol?

}

extension CastPresenter: CastPresenterProtocol {

    func viewDidLoad() {
        view?.showSpinnerView()
        interactor?.getCast()
    }
    
}

extension CastPresenter: CastInteractorOutputProtocol {
    func noCast(with message: String) {
        view?.showMessageNoCast(with: message)
        view?.stopSpinnerView()
    }
    
    func onError(errorMessage: String) {
        view?.showErrorMessage(withMessage: errorMessage)
        view?.stopSpinnerView()
    }
    
    func castFromInteractor(castViewModel: [CastViewModel]) {
        view?.showCast(castViewModel: castViewModel)
        view?.stopSpinnerView()
    }
    
}
