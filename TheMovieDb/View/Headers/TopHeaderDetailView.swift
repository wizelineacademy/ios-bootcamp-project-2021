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
                        height: UIScreen.main.bounds.width,
                        aspectRatio: .scaleAspectFill)
    .roundCorners(circle: false, radius: 0, clipped: true)
    .setBackgroundColor(color: .lightGray)
    .build()
  
  var titleLabel = LabelBuilder()
    .amountLines(numLines: 2)
    .fontStyle(textStyle: .subtitle, weight: .bold)
    .setColor(color: .darkCyan)
    .setText(text: "Title")
    .build()
  
  var releaseDateLabel = LabelBuilder()
    .fontStyle(textStyle: .paragraph, weight: .regular)
    .setColor(color: .lightGray)
    .setText(text: "release date")
    .build()
  
  var scoreTitleLabel = LabelBuilder()
    .fontStyle(textStyle: .paragraph, weight: .bold)
    .setColor(color: .darkCyan)
    .setText(text: "User Score")
    .build()

  var scoreIconImage = ImageBuilder()
    .sizeAndAspectImage(width: 20, height: 20, aspectRatio: .scaleAspectFit)
    .systemImage(iconName: "star.fill", color: .darkCyan, size: 16)
    .build()
  
  var scoreLabel = LabelBuilder()
    .fontStyle(textStyle: .subtitle, weight: .bold)
    .setColor(color: .whiteDirt)
    .build()
  
  func setupView() {
    addSubview(posterImage)
    posterImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    let infoStackView = VerticalStackView(arrangedSubviews: [titleLabel, releaseDateLabel], spacing: 0)
    infoStackView.alignment = .leading
    let scoreStack = HorizontalStackView(arrangedSubviews: [scoreTitleLabel, scoreIconImage, scoreLabel], spacing: 10)
    let allInfoStack = HorizontalStackView(arrangedSubviews: [infoStackView, scoreStack], spacing: 10)
    allInfoStack.distribution = .fill
    addSubview(allInfoStack)
    allInfoStack.anchor(top: posterImage.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
  }
  
  func setupData() {
    guard
      let moviePoster = movieDetails?.backDropPath,
      let title = movieDetails?.title,
      let releaseDate = movieDetails?.getMovieReleaseDateFormat(),
      let score = movieDetails?.voteAverage
    else {return}
    let imageProvider = ImageResource(downloadURL: URL(string: "\(ApiPath.baseUrlImage.path)\(moviePoster)")!)
    posterImage.kf.setImage(with: imageProvider)
    releaseDateLabel.text = releaseDate
    titleLabel.text = title
    scoreLabel.text = "\(score)"
  }

}
