//
//  MovieCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 29/10/21.
//

import UIKit
import Kingfisher

final class MovieCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet private var movieImageView: UIImageView?
  @IBOutlet private var movieLabel: UILabel?
  @IBOutlet private var scoreLabel: UILabel?
  
  static let identifier = "MovieCollectionViewCell"
  private var movieViewModel: MovieViewModel?
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  static func nib() -> UINib {
      return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
  }
  
  private func setupUI() {
    // Movie Image
    movieImageView?.contentMode = .scaleAspectFill
    movieImageView?.layer.cornerRadius = 10
    movieImageView?.clipsToBounds = true
    // Movie Title
    movieLabel?.textColor = .label
    movieLabel?.font = UIFont.movieTitle
    // Movie Score
    scoreLabel?.font = UIFont.movieScore
    scoreLabel?.text = ""
    
  }
  private func addInformationUI() {
    self.movieLabel?.text = movieViewModel?.title
    if movieViewModel?.score != 0 {
      self.scoreLabel?.text = "\(String(movieViewModel?.score ?? 0))"
    }
    self.setupImage(posterPath: movieViewModel?.posterPath ?? "")
  }
  func setupImage(posterPath: String) {
    if let url = URL(string: posterPath) {
      movieImageView?.kf.setImage(with: url)
    }
  }
  
  func configure(_ movieViewModel: MovieViewModel?) {
    self.movieViewModel = movieViewModel
    addInformationUI()
    
  }
  
}
