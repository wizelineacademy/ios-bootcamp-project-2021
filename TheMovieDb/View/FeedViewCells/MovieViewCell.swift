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
    .roundCorners(circle: false, radius: 10, clipped: true)
    .setBackgroundColor(color: .lightGray)
    .build()
      
  override func setupView() {
    addSubview(imageMovie)
    imageMovie.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  override func setupData() {
    guard let moviePoster = movie?.poster else {return}
    let imageProvider = ImageResource(downloadURL: URL(string: "\(ApiPath.baseUrlImage.path)\(moviePoster)")!)
    imageMovie.kf.setImage(with: imageProvider)
  }
  
}
