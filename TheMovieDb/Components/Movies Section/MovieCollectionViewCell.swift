//
//  MovieCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 29/10/21.
//

import UIKit
import Kingfisher

final class MovieCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var movieImageView: UIImageView?
  @IBOutlet weak var movieLabel: UILabel?
  @IBOutlet weak var scoreLabel: UILabel?
  
  static let identifier = "MovieCollectionViewCell"
  private var overview = ""
  private var id = 0
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  static func nib() -> UINib {
      return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
  }
  
  func setupUI() {
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
  func setupImage(posterPath: String) {
    if let url = URL(string: posterPath) {
      movieImageView?.kf.setImage(with: url)
    }
  }
  
  func configure(movieTitle: String, movieScore: Float, posterPath: String, overview: String, id: Int) {
    self.movieLabel?.text = movieTitle
    if movieScore != 0 {
      self.scoreLabel?.text = "\(movieScore)"
    }
    self.setupImage(posterPath: posterPath)
    self.overview = overview
    self.id = id
    
  }
  
}
