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
    
    static func buildHomeTabBarViewController() -> UITabBarController? {
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        guard let homeTabBarViewController = storyboad.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? UITabBarController else { return nil}
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        homeTabBarViewController.tabBar.standardAppearance = appearance

        guard let home = MoviesHomeBuilder.buildModule() else { return nil}
        let initialNavigationViewController = MoviesRouter.buildInitialNavigationControllerWith(rootViewController: home)
        
        let moviesItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        initialNavigationViewController.tabBarItem = moviesItem
        
        guard let searchView = SearchViewBuilder.buildModule() else { return nil }
        let navigationView = MoviesRouter.buildInitialNavigationControllerWith(rootViewController: searchView)
        
        let searchItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        navigationView.tabBarItem = searchItem
        
        homeTabBarViewController.viewControllers = [initialNavigationViewController, navigationView]
        
        return homeTabBarViewController
        
        }
    
}
