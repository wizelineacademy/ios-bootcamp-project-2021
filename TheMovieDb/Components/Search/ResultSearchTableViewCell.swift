//
//  ResultSearchTableViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 06/11/21.
//

import UIKit

final class ResultSearchTableViewCell: UITableViewCell {
  
  @IBOutlet private var titleLabel: UILabel?
  @IBOutlet private var imageResult: UIImageView?
  static let identifier = "ResultSearchTableViewCell"
  private var movieViewModel: MovieViewModel?
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  static func nib() -> UINib {
    return UINib(nibName: "ResultSearchTableViewCell", bundle: nil)
  }
  
  private func setupUI() {
    self.titleLabel?.text = movieViewModel?.title
    self.setupImage(posterPath: movieViewModel?.posterPath ?? "")
  }
  
  func configure(movieViewModel: MovieViewModel?) {
    self.movieViewModel = movieViewModel
    setupUI()
  }
  
  private func setupImage(posterPath: String) {
    if let url = URL(string: posterPath) {
      imageResult?.kf.setImage(with: url)
    }
  }
  
}
