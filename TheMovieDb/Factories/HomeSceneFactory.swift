//
//  HomeSceneFactory.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation
import UIKit

protocol HomeSceneFactory {
    var configurator: HomeSceneConfigurator? { get set }
    func makeHomeScene() -> UIViewController?
}

final class DefaultHomeSceneFactory: HomeSceneFactory {
    var configurator: HomeSceneConfigurator?
    
    func makeHomeScene() -> UIViewController? {
        let vc = HomeSceneViewController()
        return configurator?.configured(vc)
    }
}
