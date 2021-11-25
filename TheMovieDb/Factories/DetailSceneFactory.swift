//
//  DetailSceneFactory.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 22/11/21.
//

import Foundation
import UIKit

protocol DetailSceneFactory {
    var configurator: DetailSceneConfigurator! { get set }
    func makeDetailScene(movie: MovieModel) -> UIViewController
}

final class DefaultDetailSceneFactory: DetailSceneFactory {
    var configurator: DetailSceneConfigurator!
    
    func makeDetailScene(movie: MovieModel) -> UIViewController {
        let vc = DetailSceneViewController(movie: movie)
        return configurator.configured(vc)
    }
}
