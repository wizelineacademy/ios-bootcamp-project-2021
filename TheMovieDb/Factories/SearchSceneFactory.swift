//
//  SearchSceneFactory.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation
import UIKit

protocol SearchSceneFactory {
    var configurator: SearchSceneConfigurator? { get set }
    func makeSearchScene(request: (PageableModel & Request & SearchableModel)?) -> UIViewController?
}

final class DefaultSearchSceneFactory: SearchSceneFactory {
    
    var configurator: SearchSceneConfigurator?
    
    func makeSearchScene(request: (PageableModel & Request & SearchableModel)?) -> UIViewController? {
        let vc = SearchSceneViewController()
        return configurator?.configured(vc, request: request)
    }
}
