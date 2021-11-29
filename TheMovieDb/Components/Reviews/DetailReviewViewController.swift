//
//  DetailReviewViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import UIKit

final class DetailReviewViewController: UIViewController {
  
  @IBOutlet private var ratingLabel: UILabel?
  @IBOutlet private var authorLabel: UILabel?
  @IBOutlet private var contentLabel: UILabel?
//  private var author: String?
//  private var rating: Float?
//  private var content: String?
  private var reviewViewModel: ReviewViewModel?
  weak var coordinator: MainCoordinator?
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  init(_ reviewViewModel: ReviewViewModel?) {
    self.reviewViewModel = reviewViewModel
    super.init(nibName: "DetailReviewViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    self.navigationItem.title = self.reviewViewModel?.author
    self.contentLabel?.numberOfLines = 0
    self.authorLabel?.text = self.reviewViewModel?.author
    self.contentLabel?.text = self.reviewViewModel?.content
    self.ratingLabel?.text = "Rating: \(self.reviewViewModel?.rating ?? 0)"
  }
}
