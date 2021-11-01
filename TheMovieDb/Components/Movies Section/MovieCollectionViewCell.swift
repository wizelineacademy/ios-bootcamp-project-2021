//
//  MovieCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 29/10/21.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var movieImage: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var movieScore: UILabel!
  
  var circularProgressBarView: CircularProgressBarView!
  var circularViewDuration: TimeInterval = 2
  
  static let identifier = "MovieCollectionViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    setupUI()
    setUpCircularProgressBarView()
  }
  
  static func nib() -> UINib {
      return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
  }
  
  func setupUI() {
    // Movie Image
    movieImage.contentMode = .scaleAspectFill
    movieImage.layer.cornerRadius = 10
    movieImage.clipsToBounds = true
    // Movie Title
    movieTitle.textColor = .black
    movieTitle.font = UIFont.movieTitle
    
    // Movie Title View
//    movieTitleView.backgroundColor = UIColor.movieTitleViewGrey
//    movieTitleView.clipsToBounds = true
//    movieTitleView.layer.cornerRadius = 2
    
    // Movie Score
    movieScore.font = UIFont.movieScore
  }
  
  func setUpCircularProgressBarView() {
    // set view
    circularProgressBarView = CircularProgressBarView(frame: .zero)
    // align to the center of the screen
    circularProgressBarView.center = self.center
    // call the animation with circularViewDuration
    circularProgressBarView.progressAnimation(duration: circularViewDuration)
    // add this view to the view controller
    self.addSubview(circularProgressBarView)
  }
  
  func configure(movieTitle: String, movieScore: Float) {
    self.movieTitle.text = movieTitle
    self.movieScore.text = "\(movieScore)"
//    self.movieImage.image = movieImage
  }
  
}
