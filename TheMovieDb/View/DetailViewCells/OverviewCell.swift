//
//  OverviewCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class OverviewCell: BaseCell {
  
  static let identifier = "OverviewCell"
  
  var movieDetails: MovieDetailsViewModel? {
    didSet {
      setupData()
    }
  }

  let descriptionLabel = LabelBuilder()
    .fontStyle(textStyle: .paragraph, weight: .regular)
    .amountLines(numLines: 0)
    .setColor(color: .whiteDirt)
    .build()
  
  override func setupView() {
    clipsToBounds = true
    addSubview(descriptionLabel)
    descriptionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
  }
  
  override func setupData() {
    guard let overview = movieDetails?.overview else { return }
    self.descriptionLabel.text = overview
  }
  
}
