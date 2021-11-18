//
//  MovieViewCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit
import Kingfisher

class MovieViewCell: BaseCell {
  
  static let identifier = "MovieViewCell"
  
  var movie: Movie? {
    didSet {
      setupData()
    }
  }
  
  var imageMovie = ImageBuilder()
    .sizeAndAspectImage(width: 100, height: 100, aspectRatio: .scaleAspectFill)
    .roundCorners(circle: false, radius: SizeAndMeasures.cornerRadiusSmall.measure, clipped: true)
    .setBackgroundColor(color: .lightGray)
    .setPlaceHolder(image: UIImage(named: "notFoundImage"))
    .build()
      
  override func setupView() {
    addSubview(imageMovie)
    imageMovie.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  override func setupData() {
    let url: String?
    if let portrait = movie?.poster {
      url = "\(ApiPath.baseUrlImage.path)\(portrait)"
    } else { url = nil }
    self.imageMovie.loadImage(urlString: url)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageMovie.image = nil
  }
  
}
