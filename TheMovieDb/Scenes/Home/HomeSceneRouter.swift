//
//  HomeSceneRoutingLogic.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation
import UIKit

protocol HomeSceneRoutingLogic {
    func showListSection(section: HomeSections)
}

final class HomeSceneRouter {
    
    weak var source: UIViewController?
}

extension HomeSceneRouter: HomeSceneRoutingLogic {
    
    func showListSection(section: HomeSections) {
        let factory = DefaultListSectionSceneFactory()
        factory.configurator = DefaultListSectionSceneConfigurator()
        let viewController = factory.makeListSectionScene(section: section, request: section.request)
        if let viewController = viewController {
            source?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
