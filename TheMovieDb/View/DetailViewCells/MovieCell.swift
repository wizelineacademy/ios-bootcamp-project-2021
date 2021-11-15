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
    .roundCorners(circle: false, radius: 10, clipped: true)
    .setBackgroundColor(color: .lightGray)
    .build()
  
  override func setupView() {
    addSubview(imageMovie)
    imageMovie.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  override func setupData() {
    guard let portrait = similarOrRecommendeMovie?.posterPath else { return }
    
    let url = "\(ApiPath.baseUrlImage.path)\(portrait)"
    self.imageMovie.loadImage(urlString: url)

  }
  
}
