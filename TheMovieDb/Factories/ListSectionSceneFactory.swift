//
//  ListSectionSceneFactory.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation
import UIKit

protocol ListSectionSceneFactory {
    var configurator: ListSectionSceneConfigurator? { get set }
    func makeListSectionScene(section: HomeSections, request: (PageableModel & Request)?) -> UIViewController?
}

final class DefaultListSectionSceneFactory: ListSectionSceneFactory {
    
    var configurator: ListSectionSceneConfigurator?
    
    func makeListSectionScene(section: HomeSections, request: (PageableModel & Request)?) -> UIViewController? {
        let vc = ListSectionSceneViewController(section: section)
        return configurator?.configured(vc, request: request)
    }
}
