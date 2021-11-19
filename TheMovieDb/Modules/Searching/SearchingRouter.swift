//
//  SearchingWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

final class SearchingRouter: SearchingRouterProtocol {
    
    func showMovieDetail(from view: SearchingViewProtocol, with movie: Movie) {
        let controller = MovieDetailBuilder.createModule(with: movie)
        guard let view = view as? SearchingView else { return }
        view.navigationController?.pushViewController(controller, animated: true)
    }
}
