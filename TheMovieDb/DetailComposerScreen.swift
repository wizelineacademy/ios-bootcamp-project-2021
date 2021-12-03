//
//  DetailComposerScreen.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 22/11/21.
//

import Foundation
import UIKit

final class DetailComposerScreen {
    static func compose(client: MovieDBClient, movieSelected: MovieViewModel) -> UIViewController {
        let viewController = DetailViewController()
        let presenter = DetailViewPresenterImp(client: client, movie: movieSelected)
        viewController.presenter = presenter
        presenter.detailView = viewController
        return viewController
    }
    
}
