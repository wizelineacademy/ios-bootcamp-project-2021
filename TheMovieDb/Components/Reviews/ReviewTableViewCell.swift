//
//  ReviewTableViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell {
  
  @IBOutlet private var authorLabel: UILabel?
  @IBOutlet private var contentLabel: UILabel?
  @IBOutlet private var ratingLabel: UILabel?
  
  private var reviewViewModel: ReviewViewModel?
  static let identifier = "ReviewTableViewCell"
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  static func nib() -> UINib {
    return UINib(nibName: "ReviewTableViewCell", bundle: nil)
  }
  
  private func setupUI() {
    self.authorLabel?.text = reviewViewModel?.author
    self.ratingLabel?.text = "\(reviewViewModel?.rating ?? 0)"
    self.contentLabel?.text = reviewViewModel?.content
  }
  
  func configure(_ reviewViewModel: ReviewViewModel?) {
    self.reviewViewModel = reviewViewModel
    setupUI()
  }
  
}
