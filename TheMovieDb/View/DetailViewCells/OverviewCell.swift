//
//  OverviewCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class OverviewCell: BaseCell {
  
  static let identifier = "OverviewCell"
  
  var movieDetails: MovieDetails? {
    didSet {
      setupData()
    }
  }

  let descriptionLabel = LabelBuilder()
    .fontStyle(textStyle: .paragraph, weight: .regular)
    .amountLines(numLines: 8)
    .setColor(color: .whiteDirt)
    .setText(text: "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.")
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
