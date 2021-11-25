//
//  MainTabWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import UIKit.UIImage

class MainTabRouter: MainTabRouterProtocol {
   
    func buildControllers(build view: MainTabViewProtocol) {
        
        guard let view = view as? MainTabView else {return}
        let homeView = HomeBuilder.createModule()
        let home = view.templateNavigationController(
            unselectedImage: UIImage(systemName: InterfaceConst.homeUnselectedIcon)!,
            selectedImage: UIImage(systemName: InterfaceConst.homeSelectedIcon)!,
            title: InterfaceConst.homeTitle,
            rootViewController: homeView
        )
        
        let searchView = SearchingBuilder.createModule()
        let search = view.templateNavigationController(
            unselectedImage: UIImage(systemName: InterfaceConst.searchUnselectedIcon)!,
            selectedImage: UIImage(systemName: InterfaceConst.searchSelectedIcon)!,
            title: InterfaceConst.searchTitle,
            rootViewController: searchView )
        
        view.viewControllers = [home, search]
        
    }
    
}
