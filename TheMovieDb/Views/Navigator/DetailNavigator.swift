//
//  DetailNavigator.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 18/11/21.
//

import Foundation
import UIKit

protocol DetailNavigator {
    func goToMovieDetail(with id: MovieViewModel)
}

final class DetailNavigatorImp: DetailNavigator {
    private let navigationController: UINavigationController
    private let client: MovieDBClient
    init(navigationController: UINavigationController, client: MovieDBClient) {
        self.navigationController = navigationController
        self.client = client
    }
    
    func goToMovieDetail(with id: MovieViewModel) {
        navigationController.pushViewController(DetailComposerScreen.compose(client: client, movieSelected: id), animated: true)
    }
}
