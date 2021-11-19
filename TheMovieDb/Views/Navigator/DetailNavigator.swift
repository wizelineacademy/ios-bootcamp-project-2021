//
//  DetailNavigator.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 18/11/21.
//

import Foundation
import UIKit

protocol DetailNavigator {
    func goToMovieDetail(with id: Int)
}

final class DetailNavigatorImp: DetailNavigator {
    
    let navigationController: UINavigationController
    let viewController: UIViewController
    
    init(navigationController: UINavigationController, viewController: UIViewController){
        self.navigationController = navigationController
        self.viewController = viewController
    }
    
    func goToMovieDetail(with id: Int) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
