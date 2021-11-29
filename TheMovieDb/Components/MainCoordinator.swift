//
//  MainCoordinator.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 04/11/21.
//

import Foundation
import UIKit
final class MainCoordinator: Coordinator {
  var children = [Coordinator]()
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = MainViewController()
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: false)
  }
  
  func showDetailMovie(movieTitle: String, movieScore: Float, posterPath: String, overview: String, id: Int) {
    let viewController = MovieDetailViewController(movieTitle: movieTitle, movieScore: movieScore, posterPath: posterPath, overview: overview, id: id)
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func showReviews(id: Int) {
    let viewController = ReviewsViewController(id: id)
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func showReviewDetail(author: String, rating: Float, content: String) {
    let viewController = DetailReviewViewController(author: author, rating: rating, content: content)
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
  }
}
