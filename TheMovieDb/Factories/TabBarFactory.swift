//
//  TabBarFactory.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation
import UIKit

protocol TabBarFactory {
    
    var configurator: TabBarSceneConfigurator? { get set }
    
    func makeDetailScene(_ tabs: [UIViewController]?) -> UITabBarController?
}

final class DefaultTabBarFactory: TabBarFactory {
    
    var configurator: TabBarSceneConfigurator?
    
    func makeDetailScene(_ tabs: [UIViewController]?) -> UITabBarController? {
        return configurator?.configured(tabs)
    }
}
