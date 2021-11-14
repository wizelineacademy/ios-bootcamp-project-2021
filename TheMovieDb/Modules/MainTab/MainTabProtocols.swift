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

protocol MainTabWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createMainTabModule() -> UIViewController
    func buildControllers(build view: MainTabViewProtocol)
}

protocol MainTabPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MainTabViewProtocol? { get set }
    var wireFrame: MainTabWireFrameProtocol? { get set }
    
    func viewWillAppear()
}
