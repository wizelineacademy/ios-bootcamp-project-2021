//
//  MainTabView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

class MainTabView: UITabBarController {

    // MARK: Properties
    var presenter: MainTabPresenterProtocol?

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
   
    // MARK: - Helpers
    private func configureUI() {
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().isTranslucent = false
        tabBar.tintColor = .label
    }

}

extension MainTabView: MainTabViewProtocol {

}
