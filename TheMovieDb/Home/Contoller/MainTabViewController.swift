//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

final class MainTabViewController: UITabBarController {
    // MARK: - Properties
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .red
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().isTranslucent = false
        tabBar.tintColor = .label

    }
    
    private func configureViewControllers() {
        
        let home = templateNavigationController(
            unselectedImage: UIImage(systemName: "house")!,
            selectedImage: UIImage(systemName: "house.fill")!,
            title: "Home",
            rootViewController: HomeViewController()
            )
        
        let searchView = SearchingWireFrame.createSearchingModule()
        let search = templateNavigationController(
            unselectedImage: UIImage(systemName: "magnifyingglass")!,
            selectedImage: UIImage(systemName: "text.magnifyingglass")!,
            title: "Search",
            rootViewController: searchView )
        
        viewControllers = [home, search]
    }
    
}
