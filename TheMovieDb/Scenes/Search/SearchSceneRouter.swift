//
//  SearchSceneRouter.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation
import UIKit

protocol SearchSceneRoutingLogic {
    func showDetailMovie(_ movie: MovieModel)
    func showToast(message: String)
}

final class SearchSceneRouter {
    
    weak var source: UIViewController?
}

extension SearchSceneRouter: SearchSceneRoutingLogic {
    
    func showDetailMovie(_ movie: MovieModel) {
        let factory = DefaultDetailSceneFactory()
        factory.configurator = DefaultDetailSceneConfigurator()
        let viewController = factory.makeDetailScene(movie: movie)
        viewController?.hidesBottomBarWhenPushed = true
        if let viewController = viewController {
            source?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func showToast(message: String) {
        Toast.showToast(title: message)
    }
}


