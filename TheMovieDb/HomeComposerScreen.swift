//
//  HomeComposerScreen.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 18/11/21.
//

import Foundation
import UIKit

final class HomeScreenComposer {
    static func compose(client: MovieDBClient, navigator: DetailNavigator) -> UIViewController {
        let viewController = HomeViewController()
        let presenter = HomeViewPresenterImp(client: client, navigator: navigator)
        viewController.presenter = presenter
        presenter.viewHome = viewController
        
        return viewController
    }
    
}
