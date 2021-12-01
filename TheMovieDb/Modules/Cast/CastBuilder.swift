//
//  CastBuilder.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/11/21.
//

import Foundation

import UIKit.UIViewController

enum CastBuilder: CastBuilderProtocol {
    static func createModule(movie: Movie) -> UIViewController {
        let view = CastView()
        let castWorker: CastWorkerProtocol = CastWorker()
        let presenter: CastPresenterInteractorProtocol = CastPresenter()
        let interactor: CastInteractorInputProtocol = CastInteractor(movie: movie, castWorker: castWorker)

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }
}
