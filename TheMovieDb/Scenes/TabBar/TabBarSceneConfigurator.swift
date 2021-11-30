//
//  TabBarSceneConfigurator.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation
import UIKit

protocol TabBarSceneConfigurator {
    func configured(_ tabs: [UIViewController]?) -> TabBarSceneController?
}

final class DefaultTabBarSceneConfigurator: TabBarSceneConfigurator {
    
    @discardableResult
    func configured(_ tabs: [UIViewController]?) -> TabBarSceneController? {
        let tabBar = TabBarSceneController()
        var navigations: [UINavigationController] = []
        for tab in tabs ?? [] {
            let navigation = UINavigationController(rootViewController: tab)
            navigations.append(navigation)
        }
        tabBar.viewControllers = navigations
        // worker
        // interactor
        // presenter
        // router
        // router.source
        // presenter.vc
        // interactor.presenter
        // interactor.worker
        // vc.interactor
        // vc.router
        // return vc
        return tabBar
    }
}
