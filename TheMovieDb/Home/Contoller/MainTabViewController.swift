//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

class MainTabViewController: UITabBarController {
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
        UITabBar.appearance().backgroundColor = .systemGray6
        UITabBar.appearance().isTranslucent = true
        tabBar.tintColor = .label
    }
    
    private func configureViewControllers() {
        
        let home = templateNavigationController(unseledtedImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, title: "Home", rootViewController: HomeViewController())
        
        let search = templateNavigationController(unseledtedImage: UIImage(systemName: "magnifyingglass")!, selectedImage: UIImage(systemName: "text.magnifyingglass")!, title: "Search", rootViewController: SearchViewController())
        
        viewControllers = [home, search]
    }
    
}
