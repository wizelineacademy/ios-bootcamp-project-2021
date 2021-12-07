//
//  TabBarSceneConfigurator.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation
import UIKit

protocol TabBarSceneConfigurator {
    func configured() -> TabBarSceneController?
}

final class DefaultTabBarSceneConfigurator: TabBarSceneConfigurator {
    
    var tabs: [UIViewController] = []
    
    init() {
        if let homeViewController = getHomeSections() {
            tabs.append(homeViewController)
        }
        if let searchViewController = getSearchSections() {
            tabs.append(searchViewController)
        }
    }
    
    @discardableResult
    func configured() -> TabBarSceneController? {
        let tabBar = TabBarSceneController()
        var navigations: [UINavigationController] = []
        for tab in tabs {
            let navigation = UINavigationController(rootViewController: tab)
            navigations.append(navigation)
        }
        tabBar.viewControllers = navigations
        return tabBar
    }
    
    func getHomeSections() -> UIViewController? {
        let configuration = DefaultHomeSceneConfigurator()
        let factory = DefaultHomeSceneFactory()
        factory.configurator = configuration
        return factory.makeHomeScene()
    }
    
    func getSearchSections() -> UIViewController? {
        let configuration = DefaultSearchSceneConfigurator()
        let factory = DefaultSearchSceneFactory()
        factory.configurator = configuration
        return factory.makeSearchScene(request: SearchRequest())
    }
}
