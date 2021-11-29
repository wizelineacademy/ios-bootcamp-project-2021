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
  
  func showDetailMovie(_ movieViewModel: MovieViewModel?) {
    let viewController = MovieDetailViewController(movieViewModel: movieViewModel ?? nil)
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func showReviews(id: Int) {
    let viewController = ReviewsViewController(id: id)
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func showReviewDetail(_ reviewViewModel: ReviewViewModel?) {
    let viewController = DetailReviewViewController( reviewViewModel)
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
  }
}
