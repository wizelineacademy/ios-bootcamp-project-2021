//
//  TopHeaderDetailView.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import Foundation
import UIKit
import Kingfisher

class TopHeaderDetailView: UICollectionReusableView {
  
  static let identifier = "TopHeaderDetailView"
  
  var movieDetails: MovieDetails? {
    didSet {
      setupData()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  var posterImage = ImageBuilder()
    .sizeAndAspectImage(width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.width / 1.3,
                        aspectRatio: .scaleAspectFill)
    .roundCorners(circle: false, radius: 0, clipped: true)
    .setBackgroundColor(color: .transparentWhite)
    .setPlaceHolder(image: UIImage(named: "notFoundImage"))
    .build()
  
  var titleLabel = LabelBuilder()
    .amountLines(numLines: 2)
    .fontStyle(textStyle: .headline, weight: .bold)
    .setColor(color: .purple)
    .setText(text: "Title")
    .build()
  
  var releaseDateLabel = LabelBuilder()
    .fontStyle(textStyle: .caption, weight: .regular)
    .setColor(color: .lightGray)
    .setText(text: "release date")
    .build()
  
  var scoreTitleLabel = LabelBuilder()
    .fontStyle(textStyle: .caption, weight: .bold)
    .setColor(color: .darkGray)
    .setText(text: "User Score")
    .build()

  var scoreIconImage = ImageBuilder()
    .sizeAndAspectImage(width: 15, height: 15, aspectRatio: .scaleAspectFit)
    .systemImage(iconName: "star.fill", color: .purple, size: 12)
    .build()
  
  var scoreLabel = LabelBuilder()
    .fontStyle(textStyle: .caption, weight: .bold)
    .setColor(color: .whiteDirt)
    .build()
  
  func setupView() {
    addSubview(posterImage)
    posterImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    posterImage.constrainWidth(constant: UIScreen.main.bounds.width)
    posterImage.constrainHeight(constant: UIScreen.main.bounds.width / 1.3)
    
    let scoreStack = HorizontalStackView(arrangedSubviews: [scoreTitleLabel, scoreIconImage, scoreLabel], spacing: 10)
    let releaseStack = HorizontalStackView(arrangedSubviews: [releaseDateLabel, UIView(), scoreStack])
    scoreStack.distribution = .fillProportionally
    let infoStackView = VerticalStackView(arrangedSubviews: [titleLabel, releaseStack], spacing: 0)
    infoStackView.alignment = .fill
    infoStackView.distribution = .fill
    addSubview(infoStackView)
    infoStackView.anchor(top: posterImage.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
  }
  
  func setupData() {
    guard
      let title = movieDetails?.title,
      let releaseDate = movieDetails?.getMovieReleaseDateFormat(),
      let score = movieDetails?.voteAverage
    else {return}
    
    let moviePoster = movieDetails?.backDropPath
    let url: String?
    if moviePoster != nil {
      url = "\(ApiPath.baseUrlImage.path)\(moviePoster ?? "")"
    } else { url = nil }
    posterImage.loadImage(urlString: url)
    releaseDateLabel.text = releaseDate
    titleLabel.text = title
    scoreLabel.text = "\(score)"
  }

}
