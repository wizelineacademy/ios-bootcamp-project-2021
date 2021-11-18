//
//  MovieCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class MovieCell: BaseCell {
  
  static let identifier = "MovieCell"
  
  var similarOrRecommendeMovie: SimilarOrRecommendedMovie? {
    didSet {
      setupData()
    }
  }
  
  var imageMovie = ImageBuilder()
    .sizeAndAspectImage(width: 100, height: 200, aspectRatio: .scaleAspectFill)
    .roundCorners(circle: false, radius: SizeAndMeasures.cornerRadiusSmall.measure, clipped: true)
    .setBackgroundColor(color: .lightGray)
    .setPlaceHolder(image: UIImage(named: "notFoundImage"))
    .build()
  
  override func setupView() {
    addSubview(imageMovie)
    imageMovie.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
  }
  
  override func setupData() {
    let url: String?
    if let portrait = similarOrRecommendeMovie?.posterPath {
      url = "\(ApiPath.baseUrlImage.path)\(portrait)"
    } else { url = nil }
    self.imageMovie.loadImage(urlString: url)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageMovie.image = nil
  }
  
}
