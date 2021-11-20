//
//  MainTabProtocols.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

protocol MainTabViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MainTabPresenterProtocol? { get set }
}

protocol MainTabRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    func buildControllers(build view: MainTabViewProtocol)
}

protocol MainTabBuilderProtocol: AnyObject {
    // BUILDER
    static func createModule() -> UIViewController
}

protocol MainTabPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MainTabViewProtocol? { get set }
    var router: MainTabRouterProtocol? { get set }
    
    func viewWillAppear()
}
