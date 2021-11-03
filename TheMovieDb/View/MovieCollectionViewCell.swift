//
//  MovieCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation
import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
  
  var movie: Movie? {
    didSet {
      setupView()
    }
  }
  
  static let identifier = "movieCollectionViewCell"
  // base url provided for the api for downloading images
  var baseUrlImage = "https://image.tmdb.org/t/p/w500/"
  // UI var conections with the nib
  @IBOutlet private weak var posterImage: UIImageView!
  @IBOutlet private weak var movieTitle: UILabel!
  @IBOutlet private weak var releaseDate: UILabel!
 
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  // setup UI
  func setupView() {
    
    backgroundColor = DesignColor.whiteDirt.color
    layer.cornerRadius = 20
    clipsToBounds = true
    
    guard let title = movie?.title, let releaseDate = movie?.releaseDate, let posterPath = movie?.poster else { return }
    let date = releaseDate.components(separatedBy: "-")
    let month = SetMonth.Jan
    // set info title
    self.movieTitle.text = title
    self.movieTitle.textColor = DesignColor.darkGray.color
    // set info release date
    self.releaseDate.text = month.setMonth(date: date)
    self.releaseDate.textColor = DesignColor.gray.color
    // set image with url and kingFisher
    let url = URL(string: "\(baseUrlImage)\(posterPath)")
    let imageProvider = ImageResource(downloadURL: url!)
    self.posterImage.kf.setImage(with: imageProvider)
    
  }
   
  static func nib() -> UINib {
      return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
  }
  
}
