//
//  MainTabWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

class MainTabRouter: MainTabRouterProtocol {
   
    func buildControllers(build view: MainTabViewProtocol) {
        
        guard let view = view as? MainTabView else {return}
        let homeView = HomeBuilder.createModule()
        let home = view.templateNavigationController(
            unselectedImage: UIImage(systemName: "house")!,
            selectedImage: UIImage(systemName: "house.fill")!,
            title: "Home",
            rootViewController: homeView
        )
        
        let searchView = SearchingBuilder.createModule()
        let search = view.templateNavigationController(
            unselectedImage: UIImage(systemName: "magnifyingglass")!,
            selectedImage: UIImage(systemName: "text.magnifyingglass")!,
            title: "Search",
            rootViewController: searchView )
        
        view.viewControllers = [home, search]
        
    }
    
}
