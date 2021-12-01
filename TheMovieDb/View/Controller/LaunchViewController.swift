//
//  LaunchViewController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/30/21.
//

import UIKit

class LaunchViewController: UIViewController {
  
  let logoImage = ImageBuilder()
    .sizeAndAspectImage(width: 150, height: 150, aspectRatio: .scaleAspectFit)
    .build()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      self?.setNavigationController()
    }
  }
  
  private func setupView() {
    view.backgroundColor = DesignColor.black.color
    logoImage.image = UIImage(named: "iconApp")
    logoImage.constrainWidth(constant: 150)
    logoImage.constrainHeight(constant: 150)
    view.addSubview(logoImage)
    logoImage.centerXInSuperview()
    logoImage.centerYInSuperview()
    logoImage.layer.opacity = 0.2
  }
  
  private func setNavigationController() {
    let apiClient = MovieClient.shared
    let feedViewController = FeedViewController(apiClient: apiClient)
    let navigationController = UINavigationController()
    navigationController.viewControllers = [feedViewController]
    navigationController.modalPresentationStyle = .fullScreen
    self.present(navigationController, animated: true)
  }
}
