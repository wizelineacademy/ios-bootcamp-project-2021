//
//  CastCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class CastCell: BaseCell {
  
  static let identifier = "CastCell"
  
  var person: PersonViewModel? {
    didSet {
      setupData()
    }
  }
  
  var profileImage = ImageBuilder()
    .aspectImage(aspectRatio: .scaleAspectFill)
    .roundCorners(circle: true, radius: SizeAndMeasures.profilePictureBig.measure, clipped: true)
    .setPlaceHolder(image: UIImage(named: "notFoundImage"))
    .setBackgroundColor(color: .transparentWhite)
    .build()
  
  var nameLabel = LabelBuilder()
    .fontStyle(textStyle: .subheadline, weight: .bold)
    .setColor(color: .gray)
    .build()
  
  var characterLabel = LabelBuilder()
    .fontStyle(textStyle: .subheadline, weight: .regular)
    .setColor(color: .darkGray)
    .build()
  
  override func setupView() {
    
    backgroundColor = DesignColor.transparentWhite.color
    layer.cornerRadius = SizeAndMeasures.cornerRadiusBig.measure

    let widthAndHeightProfileImage = SizeAndMeasures.profilePictureBig.measure
    profileImage.constrainWidth(constant: widthAndHeightProfileImage)
    profileImage.constrainHeight(constant: widthAndHeightProfileImage)

    let infoStack = VerticalStackView(arrangedSubviews: [nameLabel, characterLabel], spacing: 0)
    
    let allInfoStack = HorizontalStackView(arrangedSubviews: [profileImage, infoStack], spacing: 10)
    addSubview(allInfoStack)
    allInfoStack.alignment = .center
    allInfoStack.centerYInSuperview()
    allInfoStack.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))

  }
  
  override func setupData() {
    guard let name = person?.name else { return }
    profileImage.loadImage(urlString: person?.profilePath)
    self.nameLabel.text = name
    guard let character = person?.character else { return }
    self.characterLabel.text = character
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    profileImage.image = nil
  }

}
