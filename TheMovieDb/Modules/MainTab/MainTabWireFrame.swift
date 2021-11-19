//
//  MainTabWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

class MainTabWireFrame: MainTabWireFrameProtocol {
    class func createMainTabModule() -> UIViewController {
        let presenter: MainTabPresenterProtocol = MainTabPresenter()
        let view = MainTabView()
        let wireFrame: MainTabWireFrameProtocol = MainTabWireFrame()
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        return view
    }
    
    func buildControllers(build view: MainTabViewProtocol) {
        
        guard let view = view as? MainTabView else {return}
        let homeView = HomeWireFrame.createHomeModule()
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
