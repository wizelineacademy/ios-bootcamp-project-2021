//
//  DetailReviewViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import UIKit

class DetailReviewViewController: UIViewController {
  
  @IBOutlet weak var ratingLabel: UILabel?
  @IBOutlet weak var authorLabel: UILabel?
  @IBOutlet weak var contentLabel: UILabel?
  private var author: String?
  private var rating: Float?
  private var content: String?
  weak var coordinator: MainCoordinator?
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  init(author: String, rating: Float, content: String) {
    self.author = author
    self.content = content
    self.rating = rating
    super.init(nibName: "DetailReviewViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupUI() {
    self.navigationItem.title = self.author
    self.contentLabel?.numberOfLines = 0
    self.authorLabel?.text = self.author
    self.contentLabel?.text = self.content
    self.ratingLabel?.text = "Rating: \(self.rating ?? 0)"
  }
}
