//
//  HomeWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

class HomeWireFrame: HomeRouterProtocol {

    func showMovie(from view: HomeViewProtocol, with movie: Movie) {
        let controller = MovieDetailBuilder.createModule(with: movie)
        guard let view = view as? HomeView else { return }
        view.navigationController?.pushViewController(controller, animated: true)
    }
    
}
