//
//  MovieCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
  
  var movie: Movie? {
    didSet{
      setupView()
    }
  }
  
  static let identifier = "movieCollectionViewCell"
  var baseUrlImage = "https://image.tmdb.org/t/p/w500/"
  
  @IBOutlet var posterImage: UIImageView!
  @IBOutlet var movieTitle: UILabel!
  @IBOutlet var releaseDate: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setupView(){
    backgroundColor = .white
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 0.2
    layer.cornerRadius = 20
    clipsToBounds = true
    guard let title = movie?.title, let releaseDate = movie?.releaseDate, let posterPath = movie?.poster else { return }
    self.movieTitle.text = title
    self.releaseDate.text = releaseDate
    let url = URL(string: "\(baseUrlImage)\(posterPath)")
    let imageProvider = ImageResource(downloadURL: url!)
    self.posterImage.kf.setImage(with: imageProvider)
    
  }
  
  static func nib() -> UINib{
      return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
  }
  
}
