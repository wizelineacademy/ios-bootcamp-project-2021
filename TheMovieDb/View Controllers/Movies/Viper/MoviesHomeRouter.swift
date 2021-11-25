//
//  MoviesHomeRouter.swift
//  TheMovieDb
//
//  Created by developer on 20/11/21.
//

import Foundation
import UIKit

final class MoviesHomeRouter: MoviesHomeRouterProtocol {
    func showErrorAlertFrom(view: UIViewController, message: String) {
        view.present(AlertsBuilderCreator.createAlertWith(message: message), animated: true, completion: nil)
    }
    
    func pushDetailViewControllerFrom(view: UIViewController, with movie: MovieProtocol) {
        guard let detailViewController = MoviesDetailBuilder.buildModuleWith(movie: movie) else { return }
        view.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
