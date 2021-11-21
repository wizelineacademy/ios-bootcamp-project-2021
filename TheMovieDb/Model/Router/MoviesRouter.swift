//
//  MoviesRouter.swift
//  TheMovieDb
//
//  Created by developer on 20/11/21.
//

import Foundation
import UIKit

final class MoviesRouter {
    static func buildInitialNavigationControllerWith(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.backgroundColor = .black
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.topItem?.backButtonTitle = "" 
        return navigationController
    }
    
}
