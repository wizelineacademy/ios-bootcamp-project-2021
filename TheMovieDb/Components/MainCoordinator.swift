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
    let vc = MainViewController()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: false)
  }
  
  func showDetailMovie(movieTitle: String, movieScore: Float, posterPath: String, overview: String, id: Int) {
    let vc = MovieDetailViewController(movieTitle: movieTitle, movieScore: movieScore, posterPath: posterPath, overview: overview, id: id)
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }
  
  func showReviews(id: Int) {
    let vc = ReviewsViewController(id: id)
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }
  
  func showReviewDetail(author: String, rating: Float, content: String) {
    let vc = DetailReviewViewController(author: author, rating: rating, content: content)
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }
}
