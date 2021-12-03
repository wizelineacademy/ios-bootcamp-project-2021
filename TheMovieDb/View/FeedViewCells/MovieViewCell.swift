//
//  MovieViewCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class MovieViewCell: BaseCell {
  
  static let identifier = "MovieViewCell"
  
  var movie: MovieViewModel? {
    didSet {
      setupData()
    }
  }
  
  var imageMovie = ImageBuilder()
    .sizeAndAspectImage(width: 100, height: 100, aspectRatio: .scaleAspectFill)
    .roundCorners(circle: false, radius: SizeAndMeasures.cornerRadiusSmall.measure, clipped: true)
    .setBackgroundColor(color: .transparentWhite)
    .setPlaceHolder(image: UIImage(named: "notFoundImage"))
    .build()
      
  override func setupView() {
    addSubview(imageMovie)
    imageMovie.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  override func setupData() {
    self.imageMovie.loadImage(urlString: movie?.poster)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageMovie.image = nil
  }
  
}
